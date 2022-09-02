Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E325AA9DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiIBIXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiIBIXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:23:12 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2368ADCE7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:23:10 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220902082303epoutp01ff76bc4815485ddc32f3b60f8936c448~Q-X7RbPoM1295812958epoutp01B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:23:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220902082303epoutp01ff76bc4815485ddc32f3b60f8936c448~Q-X7RbPoM1295812958epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662106983;
        bh=6/Xt6T1+Ee7YepCFXOa2UQ/fraRQeGmtbuSNUh62rp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HMWCFL9V/jU+KiTRlEtj3U7aB6o7VfqKRMGdNDT7IYZ3rBjEciHUjWZc56jcHHWpT
         9FOU4KlIv1vT4RHG7j/WjRiteglQTDi6BIRndwZJvxgu5xPeZEnuyEXYDgThAK04By
         QJvjxsPSiqvKJtdzpym/iVC3WUaErHztzMj3jPPU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220902082303epcas1p133060fd10efa202a7baa0ce9fd1dbb6e~Q-X65qOiw0713307133epcas1p1p;
        Fri,  2 Sep 2022 08:23:03 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.236]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MJrWp1W1mz4x9Q8; Fri,  2 Sep
        2022 08:23:02 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.AE.15556.66DB1136; Fri,  2 Sep 2022 17:23:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220902082301epcas1p4689f8cdbe675e224b595ceac57b3eadf~Q-X5XYsFl2971929719epcas1p4O;
        Fri,  2 Sep 2022 08:23:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220902082301epsmtrp2ae01c5ffca335387ee1ba50290428f0a~Q-X5Wp9B10260902609epsmtrp2F;
        Fri,  2 Sep 2022 08:23:01 +0000 (GMT)
X-AuditID: b6c32a37-5b9ff70000003cc4-69-6311bd66069f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.B8.18644.56DB1136; Fri,  2 Sep 2022 17:23:01 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220902082301epsmtip239d159fc269f4f459a8e4184b8aa467e~Q-X5MBmiu2334023340epsmtip22;
        Fri,  2 Sep 2022 08:23:01 +0000 (GMT)
Date:   Fri, 2 Sep 2022 17:23:01 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com
Subject: Re: [PATCH 1/9] trinity: Add base driver
Message-Id: <20220902172301.b41588d3342b87e7c415bdc6@samsung.com>
In-Reply-To: <YxD7kWBl88kMbdi5@sirena.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTQDdtr2CyweTbnBZ/Jx1jt5j68Amb
        RfPi9WwWl3fNYbO43biCzeL5tOssDmwev39NYvTYtKqTzWP/3DXsHn1bVjF6fN4kF8AalW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SBkkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAtECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y9Pb
        FewFrVwVJ083MTUw9rN3MXJySAiYSGw518rYxcjFISSwg1Fiw/29UM4nRommhiXMEM5nRokJ
        p66wwLQ0/VjFApHYxShx6tZ/Vging0li6cdTbF2MHBwsAioSy6ZGgjSwCahKzJyxBmyfiICy
        xNXve8GamQUaGSX+NXxgAkkICxhKbLgxCWwDr4CjxNO598FsTgFdiecLPjBCbLaQuNuzghVk
        Pq+AoMTfHcIgYWYBeYntb+cwg4QlBL6yS2xhhah2kXiw5DIbhC0s8er4FqiXpSQ+v9sLFc+W
        mNKxCOqvAolzz7dCjTGWuLgiBcRkFtCUWL9LH6JCUWLn77mMEEv5JN597WGFqOaV6GgTgihR
        kljy5zDUIgmJqTO+MUHYHhJTp1xlh4TTE0aJ6223WScwKsxCeGUWkldmISxewMi8ilEstaA4
        Nz212LDAGB67yfm5mxjBqVHLfAfjtLcf9A4xMnEwHmKU4GBWEuGdelggWYg3JbGyKrUoP76o
        NCe1+BCjKTBeJjJLiSbnA5NzXkm8oYmlgYmZkbGJhaGZoZI4r542Y7KQQHpiSWp2ampBahFM
        HxMHp1QDE89FQb6nt+9wrHsq+Yh15pL5z79Vrdl/9OJ/nrS+JY/qLsln+x6TSDX4cI7r0uXj
        EcKLFN/8YY3tV38V4nXFYsLdl9V5G/s5fY7x/VM0E7n9oH8R17nM7Q9XTNT7Jv0g4r/5i6KL
        Pq4i3Hu4dxlpngq9HjuX5ZpZeYGHTilHydnoRUYskqczLbmzb86dKsLYs6H1jYV8zNVK95kP
        Alysi0PDPr3duGN55OznfwLrNSZM7y7vfLqL69ErkdQrye/uql7Q/O7UJcjX6Osda7t9ilPb
        +S07nx+v5f1+nptfKqeGp61+yTb/6+bTA1aKNdpmudVs1wu99KArfFXUEUPLhJquMpmaNPuK
        YOM9n5LeK7EUZyQaajEXFScCALs3uLIWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvG7qXsFkgwnb5Cz+TjrGbjH14RM2
        i+bF69ksLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixaVUnm8f+uWvYPfq2rGL0+LxJLoA1issm
        JTUnsyy1SN8ugStj09sV7AWtXBUnTzcxNTD2s3cxcnJICJhINP1YxdLFyMUhJLCDUeLgvjXM
        EAkJiU33lgPZHEC2sMThw8UQNW1MEqtP/mAEibMIqEgsmxoJUs4moCoxc8YasJkiAsoSV7/v
        BZvJLNDIKHHkwzKwmcIChhIbbkxiAbF5BRwlns69D2ZzCuhKPF/wgRFiwRNGiettt1khjrCQ
        uNuzghVkGa+AoMTfHcIgYWYBLYmHv26xQNjyEtvfzmGewCg4C6FqFpKqWUiqFjAyr2KUTC0o
        zk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA58La0djHtWfdA7xMjEwXiIUYKDWUmEd+phgWQh
        3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamJJE5qX+ioj9
        IlYhcLA1j/dMnFLYtJcCr65tjq+Sr3psuCrR/zVb8dz1j39MiWpmfaqVKcu7oV3zE8uuNxMX
        itwoe/b2pF5h8FWdy5/d8uqvFofPsYsJEDS/+pBV6LnTrinxvX7O1/+kcpvymEe112sbpT24
        aXPnw9VDU9xdw6ri5Kd92CSlGCZw7Ekh19ENCy6tlWdVDfW2nHj61Q575qBL5p7b358455KW
        fj3pS6brr0IR6e+s1Zf3zSnU2qf8pe9l+VpTZqXbRnNfW8lbaZ7Re1ARm87eE+Pgsb1CVeBs
        R8qKT74vN832ytzx+nXT+zz3skvdHFu8+jVuWuedvLDn9p7KtUnPgzPFJgQ+VWIpzkg01GIu
        Kk4EAHKtYEHrAgAA
X-CMS-MailID: 20220902082301epcas1p4689f8cdbe675e224b595ceac57b3eadf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065309epcas1p4565e7bb0fea1aaf3e5e300de00774c2a
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065309epcas1p4565e7bb0fea1aaf3e5e300de00774c2a@epcas1p4.samsung.com>
        <20220725065308.2457024-2-jiho.chu@samsung.com>
        <YxD7kWBl88kMbdi5@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 19:36:01 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jul 25, 2022 at 03:53:00PM +0900, Jiho Chu wrote:
> 
> > +	drv->opened = drv->opened - 1;
> > +	if (drv->opened == 0) {
> > +		/* wait already submitted requests */
> > +		if (drv->desc->drain_reqs)
> > +			drv->desc->drain_reqs(drv);
> 
> > +		drv->desc->set_state(drv, TRINITY_STATE_PAUSE);
> 
> > +	mutex_lock(&drv->lock);
> > +	/** remove PAUSE set on the CP of the NPU */
> > +	if (drv->opened == 0) {
> > +		ret = trinity_wait_ready(drv);
> > +		if (ret != 0)
> > +			goto out;
> > +	}
> > +	drv->opened = drv->opened + 1;
> 
> Would it perhaps be cleaner to hold a runtime PM reference on the
> device for each file and deal with the power up/down of the hardware in
> the runtime PM callbacks?

Hi, Mark.
This open count will be removed as Greg's review.
Anyway, the PM callback for suspend/resume is defined on device_driver struct.

@@ -1400,6 +1833,7 @@ static struct platform_driver trinity_triv2 = {
                        .name = "triv2",
                        .owner = THIS_MODULE,
                        .of_match_table = of_match_ptr(trinity_match),
+                       .pm = &triv2_dev_pm_ops,
                },
 };

Thanks.
Jiho Chu

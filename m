Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BCA4B1C22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347259AbiBKCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:22:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbiBKCWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:22:10 -0500
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 18:22:10 PST
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4FB33
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:22:09 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220211021557epoutp0397a07cb1738b65b09f9df986a5865518~SmadJbBKR0340403404epoutp03g
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:15:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220211021557epoutp0397a07cb1738b65b09f9df986a5865518~SmadJbBKR0340403404epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644545757;
        bh=RzlOp7xQkyQ/B4cTCD1RR/Q2R2KE9RplTKZCwguaoNA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=JjxuvQ1je9cMwaNEALil8olEtIL+QbgnHQy73fmeQrh3/FguRxVoErf0u5siYoSs3
         X0CIGEONcYiXadCKTu9ARrvfUJnQ/7bKZZVeCAND56Lz/6227JmQwnRSwkEHgw0HGe
         BkpYRlV2YV9NdHwDYQhqKc0+tiJw6ZaBZyAhBMrU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220211021557epcas2p434a6be1281038c1d1b1ee8eb0de3ce76~SmacvayQw1046710467epcas2p4P;
        Fri, 11 Feb 2022 02:15:57 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.70]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Jvxzv3S5yz4x9QG; Fri, 11 Feb
        2022 02:15:55 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.0F.10014.995C5026; Fri, 11 Feb 2022 11:10:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220211021552epcas2p461fd898f8b28fa90982a7c52e2faba14~SmaYXMujD1044710447epcas2p4P;
        Fri, 11 Feb 2022 02:15:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220211021552epsmtrp17a20b7f7d78e00ec8fbd2ebdd8ccfebc~SmaYWPL6q0244802448epsmtrp1S;
        Fri, 11 Feb 2022 02:15:52 +0000 (GMT)
X-AuditID: b6c32a47-489ff7000000271e-51-6205c5998434
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.A8.29871.8D6C5026; Fri, 11 Feb 2022 11:15:52 +0900 (KST)
Received: from KORCO011456 (unknown [10.229.18.123]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220211021552epsmtip219e92a2bce125531c8c25099fab4d6dc~SmaYEqWpF1330013300epsmtip2Q;
        Fri, 11 Feb 2022 02:15:52 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Avri Altman'" <Avri.Altman@wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <beanhuo@micron.com>,
        <cang@codeaurora.org>, <adrian.hunter@intel.com>,
        <sc.suh@samsung.com>, <hy50.seo@samsung.com>,
        <sh425.lee@samsung.com>, <bhoon95.kim@samsung.com>,
        <vkumar.1997@samsung.com>
In-Reply-To: <DM6PR04MB657519E60FAFA19434531CE2FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
Subject: RE: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
Date:   Fri, 11 Feb 2022 11:15:55 +0900
Message-ID: <007101d81eed$4d120a60$e7361f20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI4IgZMS69T+T+3eQm0GbWo6Fi0ygFitYZoAa2Aj1mrtRR/gA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmqe7Mo6xJBtveW1ucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBaf1i9jtVi9+AGLxaIb25gsLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYvFnfsfWRz4PC739TJ5LN7zksljwqIDjB7f13eweXx8eovFo2/LKkaPz5vkPNoPdDMF
        cERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHa6k
        UJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpM
        yM54cPEeS8Fx9oqe7VNZGhg3s3YxcnJICJhIPG/fztbFyMUhJLCDUaJ5eycjhPOJUeLyuw/M
        IFVCAt8YJaZ9yIHpWLtvFlR8L6PEpr4yiIaXjBKdjx+zgSTYBLQlpj3cDbZCRKCVWWL9Pz0Q
        m1MgVuJ+TxNYjTCQfWP7dTCbRUBV4uuUR2D1vAKWEtPvH2aHsAUlTs58wgJiMwPNXLbwNTPE
        EQoSP58uA6pnB5rvJLFNCKJCRGJ2ZxszyDkSAhc4JFbPXsEIUe4icenTRSYIW1ji1fEt7BC2
        lMTL/jYgmwPILpbYtE8eoreBUWLJp80sEDXGErOetTOC1DALaEqs36UPUa4sceQW1GF8Eh2H
        /0JN4ZXoaBOCaFSW+DVpMtQBkhIzb96BKvGQ6FyUNYFRcRaSD2ch+XAWkl9mIaxdwMiyilEs
        taA4Nz212KjAGB7Pyfm5mxjByVnLfQfjjLcf9A4xMnEwHmKU4GBWEuE9Vc+cJMSbklhZlVqU
        H19UmpNafIjRFBjmE5mlRJPzgfkhryTe0MTSwMTMzNDcyNTAXEmc1ytlQ6KQQHpiSWp2ampB
        ahFMHxMHp1QDk8Oc9qhDurEW/9TDSivyfI7Nftnctq7bQ5Vh2ZHu2fpJcWln39gdYRe8Jsox
        tWavglG//inx248e3uFeFjxbiH+x1sL6qXFh/+ofThCSm6+QpmGkPvlbs+dN1sUSj4JTfIqn
        b8pcXfIohz/m4bZ9S/8vNvwzf1HO5V/mq98yfD+y6cfLqF5Nx7YzvFFRE7/VfbnaoS8+L178
        6/7rk2JaLb4tLlrlcWBqyOdl577u3n3J5tBUKXGtGQcv2H0qu+ldELDGtp5DqfYgg//VC7oO
        3LdL3fbrzt32jb1AQn2BrpAvd7vJwk6Gqa8j3mnu611+KWeqv8u3xIC3/44+XVD3p1Gilite
        /Tmf6oNrXr+EfJRYijMSDbWYi4oTAdfsCSVXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvO6NY6xJBnPPSlicfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Xi69JnrBaf1i9jtVi9+AGLxaIb25gsLu+aw2bRfX0Hm8Xy4/+YLLru3mC0
        WPrvLYvFnfsfWRz4PC739TJ5LN7zksljwqIDjB7f13eweXx8eovFo2/LKkaPz5vkPNoPdDMF
        cERx2aSk5mSWpRbp2yVwZfROOslccIq9YvmdZewNjBtYuxg5OSQETCTW7pvF3MXIxSEksJtR
        YkfXbWaIhKTEiZ3PGSFsYYn7LUdYIYqeM0pM+HmCHSTBJqAtMe3hbrCEiMBUZoneyV+ZIKpe
        MEqsXjQPbBSnQKzE/Z4mNhBbWCBaYvuEn0wgNouAqsTXKY/A7uAVsJSYfv8wO4QtKHFy5hMW
        EJsZaEPvw1ZGGHvZwtdQ5ylI/Hy6DKiXHWizk8Q2IYgKEYnZnW3MExiFZiEZNAvJoFlIBs1C
        0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwbGpp7mDcvuqD3iFGJg7GQ4wS
        HMxKIryn6pmThHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCU
        amDauHm66t4NK35EFx1tKruZeNWuqbM3wPvD2raFa4RPFXVUzO9py5eY0RtoEfblZ+GpcwxB
        loW6xy7uL1jt8Hb5q1bN7QrTZj49/6rsR0h6orVxob9iVqKj0Krq7KXdCv8ECmYJqbrrBtrs
        jv77IbWQ+dHcSZzM5dq6BwofsHasvm1903VSwOnT3HG6Tov+NzU9ebrlie2Wm8G9F85yTfv6
        IHrbl2WLL15Q6rg/ZwfT/jtxNyduEPKzSsr3EL+kv+62SE7qI4s1aabifBcMums8jpytrlmr
        +27xtVWz1W7/X7xzuog/y8Lg3bkvs13+3M0IFp3t1c6/I8VjzsQ3B8xXV+gHNsb635WzWXBH
        lCtWiaU4I9FQi7moOBEAo19tezwDAAA=
X-CMS-MailID: 20220211021552epcas2p461fd898f8b28fa90982a7c52e2faba14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220205074128epcas2p40901c37a7328e825d8697f8d3269edba
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
        <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
        <DM6PR04MB657519E60FAFA19434531CE2FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think it looks hardware specific.
> > If the feature isn't supported, I think there is no reasonto prevent
> > from
>                                                                          =
                =5E=5E=5E
> reason to
>=20
> > running other functions, such as ufshcd_queuecommand and
> It is no longer used in queuecommand since 5675c381ea51 and 8d077ede48c1

Yeah, you're right. It's just an example. I just want to tell that the lock=
 also protects things that are not related with clk scaling directly.

>=20
> > ufshcd_exec_dev_cmd, concurrently.
> >
> > So I add a condition at some points protecting with clk_scaling_lock.
> But you still need a way to serialize device management commands.
>=20
> Thanks,
> Avri

The dev cmd execution period is protected by mutex.
And actual ringing a doorbell is protected by spin lock.

Is there another reason to need clk_scaling_lock even with it?

Thanks.
Kiwoong Kim



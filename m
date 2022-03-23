Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0F4E4AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbiCWCh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiCWCh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:37:26 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB170854
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 19:35:56 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220323023550epoutp01b436aadbf59b119f87e2959aa9e4ff59~e4fO_-2Il1506215062epoutp01Z
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:35:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220323023550epoutp01b436aadbf59b119f87e2959aa9e4ff59~e4fO_-2Il1506215062epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648002950;
        bh=kTdxCSWu756/9f4L7Oul+Zy4lVBh7YkiDuX6jGayiRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KiTLlxbvkOuqPOcG2dpE4On5A63Jsiq7QJAp7+a5Bag++xSiWlWxDnSaqO2z4urfp
         UaP2q8z2NlQbiA+dIaYtkR7B3El+boUQJrNabKQXc8PfgjeB0XloG+9JurSFSH4GX/
         SOvfEAyjwaFnBoXfn78xljTAl7qIuTqz1Kv3pOg8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220323023550epcas2p490947caf70cc3d27de7d4c583ba2a237~e4fOhNV860188801888epcas2p4N;
        Wed, 23 Mar 2022 02:35:50 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KNXXF6Lfgz4x9Q1; Wed, 23 Mar
        2022 02:35:41 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.CA.25540.B778A326; Wed, 23 Mar 2022 11:35:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20220323023539epcas2p298f2d10dfe2b83662fe93e9188b07948~e4fEWQLkd0136601366epcas2p2P;
        Wed, 23 Mar 2022 02:35:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220323023539epsmtrp23886a97a7905f20ae3b076c5f503f6ae~e4fEVZTwe0057700577epsmtrp2S;
        Wed, 23 Mar 2022 02:35:39 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-77-623a877b3277
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.8A.29871.B778A326; Wed, 23 Mar 2022 11:35:39 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220323023539epsmtip2c2bca59b81ffa7f30729ad0bcc6ccf48~e4fEJ4K4W1597415974epsmtip2P;
        Wed, 23 Mar 2022 02:35:39 +0000 (GMT)
Date:   Wed, 23 Mar 2022 11:34:20 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Message-ID: <20220323023420.GC19041@ubuntu>
MIME-Version: 1.0
In-Reply-To: <ad877924-68bb-f029-258a-0cf9094265eb@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmuW51u1WSwcTHGhZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3eLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6X+3qZPBZsKvVY
        vOclk8emVZ1sHvvnrmH36NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMD
        Q11DSwtzJYW8xNxUWyUXnwBdt8wcoOuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUp
        OQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ124dYC7Ywl/x/v0ftgbG0zxdjJwcEgImEuvf
        z2DtYuTiEBLYwSjxae8kZgjnE6PE3t1n2CGcb4wSb9omssG0zJh2Ayqxl1Hi4KLPYAkhgSeM
        Elf/iIDYLAKqEo2Lt7KA2GwCWhL3fpxgBrFFBDQlrv/9DraPWeAxk0TLu+nsIAlhAVuJ6zfv
        AdkcHLwC2hJ3/kWAhHkFBCVOznzCAhLmFLCT2DrZFsQUFVCReHWwHmSKhMBcDonJt7+zgcQl
        BFwk1n2whDhTWOLV8S3sELaUxOd3e6HOL5bY9amVCaK3gVGi8QHEaRICxhKznrUzgtjMApkS
        yx++h5qpLHHkFgtEmE+i4/Bfdogwr0RHmxBEp7LE9MsTWCFsSYmDr89BTfSQmP7tOAskpDqZ
        JE6+7mSfwCg/C8ljs5Bsg7B1JBbs/gRkcwDZ0hLL/3FAmJoS63fpL2BkXcUollpQnJueWmxU
        YAyP6uT83E2M4GSr5b6DccbbD3qHGJk4GA8xSnAwK4nwLv5gniTEm5JYWZValB9fVJqTWnyI
        0RQYSxOZpUST84HpPq8k3tDE0sDEzMzQ3MjUwFxJnNcrZUOikEB6YklqdmpqQWoRTB8TB6dU
        A5Nj2XyD1I+L5c8w3Vg0+aLKgXaH9c4mz129PrPvvMIpNZNNwNZh0+lVaXWcAptXn1Kb/DQs
        msmIKb3PjeEI4231abdvVh/Rrjv/gGuxENu9g93qB1OP/2RZedbixozUUkN/hjOF3Maflj2a
        zecycceHvvuHBA8FKNamb/hd2bkm5vXeM83G8nN/qmivV4/e2zzp/L3/m2I+VWeuv7hS0mf+
        T4d3c169En25z/fl+oDl1/ubShIFNU7V/VjTuvPWvS2XPk1uM2BgONi8I8GbOe0Z68uuX1zh
        C31uTHHLMerUe+F6TcfhyZ0TeqyzkvOUV/Ym39BMtvlfL3RtX+OafOnfS3lqG3ftDS7/3cr8
        7Cq7EktxRqKhFnNRcSIAYrACDD8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvG51u1WSwbOVXBZPjixit2hevJ7N
        4vqf94wW7c8vsFmcP7+B3eLyrjlsFouWtTJbNG+awmoxc62yRdfdG4wOXB6X+3qZPBZsKvVY
        vOclk8emVZ1sHvvnrmH36NuyitHj8ya5APYoLpuU1JzMstQifbsErozehhcsBR95Ktb/aGRq
        YFzI1cXIySEhYCIxY9oNdhBbSGA3o8TGF9EQcUmJpXMh4hICwhL3W46wdjFyAdU8YpS48PcH
        E0iCRUBVonHxVhYQm01AS+LejxPMILaIgKbE9b/fwRqYBZ4ySSze2AbWICxgK3H95j2gqRwc
        vALaEnf+RUAM7WSS2DN7NSNIDa+AoMTJmU/AhjIDDb3x7yUTSD2zgLTE8n8cICangJ3E1sm2
        IKaogIrEq4P1ExgFZyHpnYWkdxZC7wJG5lWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmb
        GMHRoqW5g3H7qg96hxiZOBgPMUpwMCuJ8C7+YJ4kxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC
        18l4IYH0xJLU7NTUgtQimCwTB6dUA9OcsivMOyWnKNyyvVuRs/F0jNnOI3yi8ZH2/jNO3/LN
        3O/6JLK8e/fT5ZuOX2v+MElErLUg/ve1GNO4ZV/vcMx52rbF7f2LVvvAWsn1BilZSYkxHWw/
        FA8za396K/NH+uqdy9Yer515dknMeyrYMP3L1j72wht/DihvNdsfK7172fqZmX9/zH5+Oq7x
        kK61yYz9ltvYLGuPzL8qcfJiWHCua7tDQOSpkMQ3j/tP7OM4K2a6z03n5Qo3lj5h+0SHe6H+
        cu80gwwlbLJuMJwqLJQQ2jxhQVs0h7JFZoK84/uk9zMZLQXFW7ifHXFZaG283Zdt+fydxvLm
        S8X4FjfvO5Wf/7NNpWdmGGfPl6JNzkosxRmJhlrMRcWJAH/eqPYFAwAA
X-CMS-MailID: 20220323023539epcas2p298f2d10dfe2b83662fe93e9188b07948
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_23895e_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090205epcas2p15ac16f281554b663062e0e31666defab
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
        <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
        <ad877924-68bb-f029-258a-0cf9094265eb@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_23895e_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Mar 22, 2022 at 06:10:00PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2022 09:59, Daehwan Jung wrote:
> > This driver supports USB Audio offload with Co-processor.
> 
> One do you need one more XHCI driver? How does it differ from existing
> and why existing cannot be extended?

I have some exynos specific features and that's because need own driver.
It's not good to modify other XHCI driver for my features.

Additinally, I've been developing some features with other IP or Co-Processors.
Extending is not enough to cover them and I think owning driver is also better
on structural view.

Best Regards,
Jung Daehwan

> 
> > It only cares DCBAA, Device Context, Transfer Ring, Event Ring, and ERST.
> > They are allocated on specific address with xhci hooks.
> > Co-processor could use them directly without xhci driver after then.
> > 
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/host/Kconfig       |   9 +
> >  drivers/usb/host/Makefile      |   1 +
> >  drivers/usb/host/xhci-exynos.c | 982 +++++++++++++++++++++++++++++++++
> >  drivers/usb/host/xhci-exynos.h |  63 +++
> >  4 files changed, 1055 insertions(+)
> >  create mode 100644 drivers/usb/host/xhci-exynos.c
> >  create mode 100644 drivers/usb/host/xhci-exynos.h
> > 
> 
> Please address all the questions I raised in your v1, do not ignore them.
> 
> Please use get_maintainers.pl to CC all necessary people and lists. It
> makes me very sad that you do not follow the kernel development process
> (as mentioned in submitting-patches.rst and other documents).
> 
> Best regards,
> Krzysztof
> 

------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_23895e_
Content-Type: text/plain; charset="utf-8"


------2fH_v7u-qooQo7zMtxxTw1wUndVpTJhY--Wv6pszNQmaZVXq=_23895e_--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0975759C9AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbiHVUMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiHVUMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:12:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D75953031;
        Mon, 22 Aug 2022 13:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661199123;
        bh=Yr61DvE6j42KsMElufQGNSb79h22pZ+ZKTYiKvo0h3E=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZOXSbnMYN4szxajuG1iqeEVq1Okl5avFp794xqc9o1qMoThXRYsmgHG7Oq2A9b2Nx
         2d0p3epqapdTgDLt3lFtb2OUGx/Yjo9ioUIgIky+8ApIhoEayXXKYLd1Qn5JChxaH4
         BeTYLHA/++pQWLLwZ/AuCX3HYD2PbpEllTmJ3WLA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17UQ-1pREZF0zjG-012avd; Mon, 22
 Aug 2022 22:12:03 +0200
Message-ID: <b3c19a63-d9f8-028b-e59a-e428be1ed8be@gmx.de>
Date:   Mon, 22 Aug 2022 22:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] video: fbdev: chipsfb: add missing
 pci_disable_device() in chipsfb_pci_init()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Cc:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        benh@kernel.crashing.org
References: <20220819085752.1909541-1-yangyingliang@huawei.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220819085752.1909541-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iaJIJz9NwvfVUJgq3SuvteaGHMXdzmZFQ9lfmtKPDYvfREYcfas
 /M0rcTAP77PhKqc8UzkQyUQIwI+6i23y2lfeOK8n7iPfFdzrhIyAspwjm4AbwNKcGYLahC/
 CZhzRxdCNueumKvqKSYGXUPdyOE5kPzdg1oNdRXiM78urVk1r7/xVU2vetAEyRzSJSJ44zl
 0nkI60gpC5IjTSsJXdrEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x6bOX75q4ds=:JnQwJlHAqjEpfC6l5T7/lD
 +aN2YBGR1An0UL1f/A10sJbh1ssBOZlFNc++tdxaJir4SjDOzoZMg0ay7FrkrbJfDiFFqqx4R
 q+Jyy/uAkdfdKCwQDHM4jgaCM8Tm5ivnRKG04KYPc5e41sKaka46j27QY6NFqor2jKfR3xHn4
 ebksuNkV9QBZfPGk/GrsmxqkdAhnT09Xyr0naowISC61sx0Ui8V2+9Xh5sZrZFpLqAYsbZCQ7
 Ds+N3Ac+lpIPpvs5J7qu3x+hfgTrc85nViqQ+qZ+wlC0SZ5LKbMdFbMIaSZzO0i2RNBtQQabq
 TvyyCezDgR0IL4Wc16Pi7BiDqhwpsXo/FCZ0bDVC8zvLOFDJCtxBPBkmktD6wYIHK0t+hcack
 hVE7ztN/Xt/22hoa8i2g7oHAeeoLnfRkBG3b2PGm85tHicRutTG/Sr3S5lBI6I0cTqsXK8idI
 z/0YICkVVzDkLyeRzNZRtwYrHY2OMNKydjZF1oW2Q0IAO+XANI9pBI82J1ovLziY4rk+U7R2M
 Z5zKagGbc0Ua4fVCBr9v6tEPA/J7kyoZcgVSTPuiyrRj0T+nxOkXAqIbwjrxX+lTV6lWs4KSL
 DM60CTiomIOApJD8KwRWkeuIPKBg15XrqUsPbZ5B0bdUFtg/DudJj9J/1J9N1wyYGJjRQfhIf
 d+Y4Ks9ymG7TSMRkJ85v4py0hbXKIQ+ujuAIqRpZL9eXKHcn2NAfrgDHZUNwUll+UeAGE70pQ
 0ughzFXEJLc0zpv5dqfew52+NDdu2BPKUmEszaXNaWvqPN3TKkuS15bUhbDSL0b1UvDHNciKi
 6rd3VzvREdvxvSauj9aWqvXWCbHeLl6ZXR9xxuV8rCpzQ1FSUsE/BfHt/dnnWlSNQXMAu+OaA
 wtbTUYPU9Th2XxmPJLyp/LI6HVWUNOnVCJm2EIfNP2RNXOkUJXp6h0JJOazXCSi3ueEVg+vk1
 28yrFxPL4Dhh2Piw7+lRDjqDBIxyjWu0tv/f6tpC5dQ0V03FPLYJBbwhsnwkrc95gvqC4aU8w
 xUd/nn/snTXaKznoudO+uthB/mn2RvAt0Kk4iVDPfiLgPu6BdJV6rbM5NRh0xIuHF8wifa4w6
 5J30C7iAiCGZjvgZrJbftLQoFYIR1k/+rRoEshTC76u5yfVlOtM1xsjYw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/22 10:57, Yang Yingliang wrote:
> Add missing pci_disable_device() in error path in chipsfb_pci_init().
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

applied.
Thanks!
Helge

> ---
>  drivers/video/fbdev/chipsfb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb=
.c
> index 393894af26f8..2b00a9d554fc 100644
> --- a/drivers/video/fbdev/chipsfb.c
> +++ b/drivers/video/fbdev/chipsfb.c
> @@ -430,6 +430,7 @@ static int chipsfb_pci_init(struct pci_dev *dp, cons=
t struct pci_device_id *ent)
>   err_release_fb:
>  	framebuffer_release(p);
>   err_disable:
> +	pci_disable_device(dp);
>   err_out:
>  	return rc;
>  }


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D94528CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbiEPSSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244726AbiEPSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:18:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B268E2AC7E;
        Mon, 16 May 2022 11:18:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d25so14743206pfo.10;
        Mon, 16 May 2022 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hCn3RQQIcxHj2Rc/MyeJGHLc1iD9mZE44u/P4nbCcLg=;
        b=C2x5WF8ltPz6PxwtEL0p03qQkuJJtzoUgVnl6YM61tlhDfoYCNxHbRcGCkePehNzaU
         bS5x29Y6paC3iRJnzR9EW8J8GAEqgxnh0hXwoK5t4JPmMxVxkbkT3iBAZZXCdfioKn+G
         nbBQBW42nhyd/YPaVfzp8KbwnDrDiTqKaidmFBJL/mD4jz2MQSxYC0lRcSoT2/cUGW4A
         qY2s2aa9w8uV0Zs/kU1A2WdGCtwvU388V6XH2rd7hc0ujPI06fmC9CKx0lRf1vBB0VnW
         k74qPeCQ04uAtx/yeYVPpnpW2vzHAnNmebvVxZJzqpCdiPAO0xulP/p68OoTJYpTKEPn
         gRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hCn3RQQIcxHj2Rc/MyeJGHLc1iD9mZE44u/P4nbCcLg=;
        b=DcEcAKnNzc9XwuitM6xsxRN4BR/UxYRed5WCxJtqXA1qJCcjcB7IPxYeVxck3p1Od5
         TgtOETjcRHIvYDY66/74eQO0JIW8G8mHw0Ryr4PFF+lI0lv//WImLlaM6hENhmxfDIop
         v9H8iIS9zylqjwIuSJjuBQrMnyiPNwOgGQsgLRWT4+XaToZBvVU1GDBR0xp+MloA+mA0
         pml594D8W26N6EGrA/V5z8xTHKWCIZuXwHztKEItRrg+PFDXJjHEZdoc57j5k+oRrQU6
         K5+Kh77l5ax9Xdhqt5nnxNMH9VlrbKbGK5QeFglc3Z4l5WoaaDBPQNVpy3EinPPO477R
         RFIQ==
X-Gm-Message-State: AOAM530dJdESuUaWpEJ8IXfqWbnZM2Iyz4F0s/MeQWbVmaVgMoYdaVtb
        tGSbZt6uzyeBMWb34uKmc+E=
X-Google-Smtp-Source: ABdhPJx6iFibzmvKsdYDNLS5qdtLCfbmKWlJnNW881Ro+J5x/aIIxM8PJ/wm8i01ECKpOqMKUB1Rcg==
X-Received: by 2002:a65:6e9b:0:b0:3c5:f761:2d94 with SMTP id bm27-20020a656e9b000000b003c5f7612d94mr16035851pgb.79.1652725122894;
        Mon, 16 May 2022 11:18:42 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090ac09000b001d7d8b33121sm19355pjs.5.2022.05.16.11.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 11:18:42 -0700 (PDT)
Date:   Mon, 16 May 2022 11:18:40 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the bluetooth tree
Message-ID: <YoKVgMKgr1iqdXvl@yury-laptop>
References: <PH0PR11MB51264FB7874380983C3A653BD3CF9@PH0PR11MB5126.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB51264FB7874380983C3A653BD3CF9@PH0PR11MB5126.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 04:58:44PM +0000, Von Dentz, Luiz wrote:
> Hi Stephen,
> 
> Interesting, so we may want to stop using bitmap_from_u64 and replace with
> bitmap_from_arr32 given the former seems to expect at least 8 bytes:

Hi Luiz,

The problem is that br_params->flags and hdev->conn_flags are bitmaps
(declared with DECLARE_BITMAP), while cp->current_flags is declared
as u32.

Is it possible to declare cp->current_flags with DECLARE_BITMAP, or
declare local current_flags as unsigned long?
        DECLARE_BITMAP(current_flags, __HCI_CONN_NUM_FLAGS) = {cp->current_flags};

If so, you can drop this conversion to and from fixed size arrays,
in the following code and use bitmap API more consistently.

For example the line 
        if ((supported_flags | current_flags) != supported_flags)
would turn to:
        if (bitmap_subset(supported_flags, current_flags))

Alternatively, because __HCI_CONN_NUM_FLAGS == 2, and if you don't
expect adding 30+ new any flags soon, you can drop bitmap API here
and use hweight32/64 as appropriate.

Thanks,
Yury
 
>  diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 74937a834648..878be1cac5b7 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4519,7 +4519,8 @@ static int set_device_flags(struct sock *sk, struct
> hci_dev *hdev, void *data,
>                                                               cp->addr.type);
>  
>                 if (br_params) {
> -                       bitmap_from_u64(br_params->flags, current_flags);
> +                       bitmap_from_arr32(br_params->flags, &current_flags,
> +                                         __HCI_CONN_NUM_FLAGS);
>                         status = MGMT_STATUS_SUCCESS;
>                 } else {
>                         bt_dev_warn(hdev, "No such BR/EDR device %pMR (0x%x)",
> @@ -4531,7 +4532,8 @@ static int set_device_flags(struct sock *sk, struct
> hci_dev *hdev, void *data,
>                 if (params) {
>                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
>  
> -                       bitmap_from_u64(flags, current_flags);
> +                       bitmap_from_arr32(flags, &current_flags,
> +                                         __HCI_CONN_NUM_FLAGS);
>  
>                         /* Devices using RPAs can only be programmed in the
>                          * acceptlist LL Privacy has been enable otherwise they
> @@ -4546,7 +4548,8 @@ static int set_device_flags(struct sock *sk, struct
> hci_dev *hdev, void *data,
>                                 goto unlock;
>                         }
>  
> -                       bitmap_from_u64(params->flags, current_flags);
> +                       bitmap_from_arr32(params->flags, &current_flags,
> +                                         __HCI_CONN_NUM_FLAGS);
>                         status = MGMT_STATUS_SUCCESS;
>  
>                         /* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
> 
> 
> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> From: Stephen Rothwell
> Sent: Monday, May 16, 2022 12:57 AM
> To: Marcel Holtmann; Johan Hedberg; Yury Norov
> Cc: Von Dentz, Luiz; Linux Kernel Mailing List; Linux Next Mailing List
> Subject: linux-next: build warning after merge of the bluetooth tree
> 
> Hi all,
> 
> After merging the bluetooth tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> In file included from include/linux/cpumask.h:12,
>                  from include/linux/mm_types_task.h:14,
>                  from include/linux/mm_types.h:5,
>                  from include/linux/buildid.h:5,
>                  from include/linux/module.h:14,
>                  from net/bluetooth/mgmt.c:27:
> In function 'bitmap_copy',
>     inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:270:2,
>     inlined from 'bitmap_from_u64' at include/linux/bitmap.h:622:2,
>     inlined from 'set_device_flags' at net/bluetooth/mgmt.c:4534:4:
> include/linux/bitmap.h:261:9: warning: 'memcpy' forming offset [4, 7] is out of
> the bounds [0, 4] of object 'flags' with type 'long unsigned int[1]'
> [-Warray-bounds]
>   261 |         memcpy(dst, src, len);
>       |         ^~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/kasan-checks.h:5,
>                  from include/asm-generic/rwonce.h:26,
>                  from ./arch/arm/include/generated/asm/rwonce.h:1,
>                  from include/linux/compiler.h:248,
>                  from include/linux/build_bug.h:5,
>                  from include/linux/container_of.h:5,
>                  from include/linux/list.h:5,
>                  from include/linux/module.h:12,
>                  from net/bluetooth/mgmt.c:27:
> net/bluetooth/mgmt.c: In function 'set_device_flags':
> net/bluetooth/mgmt.c:4532:40: note: 'flags' declared here
>  4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
>       |                                        ^~~~~
> include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
>    11 |         unsigned long name[BITS_TO_LONGS(bits)]
>       |                       ^~~~
> 
> Introduced by commit
> 
>   a9a347655d22 ("Bluetooth: MGMT: Add conditions for setting
> HCI_CONN_FLAG_REMOTE_WAKEUP")
> 
> Bitmaps consist of unsigned longs (in this case 32 bits) ...
> 
> (This warning only happens due to chnges in the bitmap tree.)
> 
> --
> Cheers,
> Stephen Rothwell

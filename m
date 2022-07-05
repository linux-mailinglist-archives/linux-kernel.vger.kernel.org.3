Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A472C5677B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiGETXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiGETXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:23:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAC721E1D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:23:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g26so23336694ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=O5J53AdOe90BHokBmVgqqHUSfOK399rkbxJOPDlmJPM=;
        b=VoX0+sHWLjJ+PL7wDNi7gtaZ5NE5+FuXr9VEMNZIxeblfnsAtnWYouAXemcSwHWMad
         ATrT53lOQ5yXBePzhmyX4FotLFNBU+SUD5WF5UGBCYv0V6LL3A5LxGdVEN6ioNIZ9+fe
         KXVgaMli4d6Dz7aIrWvvO8jTXwydbY7vo+rp3TAjrhr+XisT5w9cV0GcgltODIwkd62V
         /5GZAT2Nt+SY55wvgzLnn6aFZpHutLAQZ72nbJgAvX/kj2uBQLCGUT/U4IM3+jE/MTkO
         9OpDhhPjyAUzWY6LiR4x3BE1R8mtCYMhpYEtK590D6wRvD8G2nuvGFI0E84PpRgKi8md
         rxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O5J53AdOe90BHokBmVgqqHUSfOK399rkbxJOPDlmJPM=;
        b=pBZpJmDtENoK3uWCfzBRouToc7KkuTVeB+qCWkrU9NmAnh7xSfy8G4hquKs92V2bFt
         iWrBkHsZPby3LWi7c3jeVfOC5Sa5K8mtCUOZkW4xG4jJK3fuNayMKXQ5yVoBqHmBV/P6
         8udtXKf85hRd/7NJol3KMomAPYuT8fDgaFWc07An0p4v4kW2s0EQwkEHfVZHvsYwUMCc
         VY4hhD73CTLA9gmPMKMQMXhWQiB+coRhOGmn3zfZHwntlyKroo8a0dNTEd9OefukMBEv
         I/I7RdpxU1ahIiANsX15UUwvbx+cJNtfABHH1Tot6Qgds047KkNDkzIN2pu01gNpVp/S
         yW2g==
X-Gm-Message-State: AJIora/c3EQpG4qt1I+1wWoTy3yHqkb2Q6c2e2nnXAx+pxNPu5/3uBIV
        tmKraRKYjbXhAV4SZIShIhs=
X-Google-Smtp-Source: AGRyM1sqz0ZswjvZYEGriTu9qvW24Q9LcTxcnCTRccK8acD5jb0mWOSyu54g253pEyuzte7enrYr5w==
X-Received: by 2002:a17:907:a048:b0:72a:ef02:b955 with SMTP id gz8-20020a170907a04800b0072aef02b955mr2311878ejc.608.1657048996655;
        Tue, 05 Jul 2022 12:23:16 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906815500b00722e7e26d22sm16223788ejw.58.2022.07.05.12.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 12:23:16 -0700 (PDT)
Message-ID: <12246439-def4-4b57-f426-461862c717c9@gmail.com>
Date:   Tue, 5 Jul 2022 21:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: r8188eu: Block comments use * on subsequent
 lines
Content-Language: en-US
To:     Rommel Rodriguez Perez <alrodperez@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <YsN993FTljv5LYT3@debianmain.debian.pc.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <YsN993FTljv5LYT3@debianmain.debian.pc.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 01:55, Rommel Rodriguez Perez wrote:
> This patch modifies a comment in order for it to comply with Linux
> Kernel style guidelines on comments belonging to  net/ or drivers/net/ by
> fixing the missing * at the beginning of each comment line and removing
> the initial almost-blank initial line from the comment block.
> 
> checkpatch output:
> WARNING: Block comments use * on subsequent lines
> 
> Signed-off-by: Rommel Rodriguez Perez <alrodperez@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_ap.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
> index ac6effbecf6d..5bd9dfa57cc5 100644
> --- a/drivers/staging/r8188eu/core/rtw_ap.c
> +++ b/drivers/staging/r8188eu/core/rtw_ap.c
> @@ -654,18 +654,17 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
>   		set_tx_beacon_cmd(padapter);
>   }
>   
> -/*
> -op_mode
> -Set to 0 (HT pure) under the following conditions
> -	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> -	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> -Set to 1 (HT non-member protection) if there may be non-HT STAs
> -	in both the primary and the secondary channel
> -Set to 2 if only HT STAs are associated in BSS,
> -	however and at least one 20 MHz HT STA is associated
> -Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> -	(currently non-GF HT station is considered as non-HT STA also)
> -*/
> +/* op_mode
> + * Set to 0 (HT pure) under the following conditions
> + *	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
> + *	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
> + * Set to 1 (HT non-member protection) if there may be non-HT STAs
> + *	in both the primary and the secondary channel
> + * Set to 2 if only HT STAs are associated in BSS,
> + *	however and at least one 20 MHz HT STA is associated
> + * Set to 3 (HT mixed mode) when one or more non-HT STAs are associated
> + *	(currently non-GF HT station is considered as non-HT STA also)
> + */
>   static int rtw_ht_operation_update(struct adapter *padapter)
>   {
>   	u16 cur_op_mode, new_op_mode;

Reviewed-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

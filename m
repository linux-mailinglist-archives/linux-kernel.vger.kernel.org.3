Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5C55B40E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiFZUpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiFZUpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:45:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A2DEB5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:45:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf9so15212338ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MU7F2k/pm1hTOOKVBfeW26d42wVGtM9C99HlX+kZFUc=;
        b=hkq3xj3zWMBNeTameJYl3wMqU54AgmIuOvE3HLzpprHwrZFr6Ib+6ps76dD9Hu9KwD
         Wsx9gBPi+h2e6J0MNZBLGUpD8WS1MyTWgNNqRTyygId39CuJpjxq7kQSJyFVUMHS7Rou
         RmYgm3hKbEtePHGJmupQTUQcpVwVOCOZ0TQuKdmDPRpPdLYV2bq9JMe86rgzXlhc+pye
         LcOFTexFtvLFzoHsNaS3DLJMZqCELGQ6Xs2Wz9BfA82PEnbdYwGxCNGKvCP/GkdoIXqe
         MtCtr0amhso5kJTTtSN11TgeZX8HFwI4afhqn+6wY0/rdRVCmIyM8Vk8XEAjYZhWJRHD
         mNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MU7F2k/pm1hTOOKVBfeW26d42wVGtM9C99HlX+kZFUc=;
        b=ezZIimueKS1F8pD1Q/0lv1B5Yn4BWRswjby37SBd/WNmd/6g5QEvZGkV8jlgqnirAp
         C9eyIC46teU6qmeFTQIrjNX+TXpK79dbpSTz0UWHb9r3ggenCJfXXleQzLUZFZvhARqs
         WzdTsqWMKAeMgo4Ryg26ySS9ZxEoEDOqXDUmnVnheTAqhBjrDtxsGs0A6b9jQkHEPvj2
         /KQv1/OKBX6+CfvCM0YM8/1151LjsBj+FIyNs/yco61vwX7CKoxwqSjCr58hn8pN2rsR
         Gcf09mxgsThl1SPjgzYSv9Dv7I/a/+I4McICxd74snM0FVPkApbeVt3It2ZckStHwWKg
         S1Lg==
X-Gm-Message-State: AJIora8QsUt3woTgX9/Qey3b4X3yJRnq1i1efiHnPyoaRP6FOBBCjBbt
        MNM31e7hUJYUPbt16yJxjyU=
X-Google-Smtp-Source: AGRyM1tud0SOqOYza3cGsDMjM6Pbh/rUJkYSqd5VKAKC7svI/bMC8Ru16aIOGSf8bO2lPwwlBti/hQ==
X-Received: by 2002:a17:906:7742:b0:708:ad9f:8e88 with SMTP id o2-20020a170906774200b00708ad9f8e88mr9498653ejn.735.1656276321829;
        Sun, 26 Jun 2022 13:45:21 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709062bc300b00722e3760558sm4081601ejg.100.2022.06.26.13.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 13:45:21 -0700 (PDT)
Message-ID: <4a6b8f5f-e859-5b19-a162-d4ff8d65490a@gmail.com>
Date:   Sun, 26 Jun 2022 22:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] staging: r8188eu: drop return value from
 receive_disconnect
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220626180734.287137-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220626180734.287137-1-martin@kaiser.cx>
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

On 6/26/22 20:07, Martin Kaiser wrote:
> The receive_disconnect function always returns _SUCCESS. None of the
> callers checks the return value. We can remove it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 5 ++---
>   drivers/staging/r8188eu/include/rtw_mlme_ext.h | 3 +--
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index cce0575e93b7..fc6e06d7b5ca 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -6191,14 +6191,14 @@ void start_clnt_assoc(struct adapter *padapter)
>   	set_link_timer(pmlmeext, REASSOC_TO);
>   }
>   
> -unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr, unsigned short reason)
> +void receive_disconnect(struct adapter *padapter, unsigned char *MacAddr, unsigned short reason)
>   {
>   	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
>   	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>   
>   	/* check A3 */
>   	if (!(!memcmp(MacAddr, get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
> -		return _SUCCESS;
> +		return;
>   
>   	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
>   		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
> @@ -6209,7 +6209,6 @@ unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr
>   			report_join_res(padapter, -2);
>   		}
>   	}
> -	return _SUCCESS;
>   }
>   
>   static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid)
> diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> index 71864733b1c0..56c0e584bb6c 100644
> --- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> +++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
> @@ -468,8 +468,7 @@ unsigned int update_MSC_rate(struct HT_caps_element *pHT_caps);
>   void Update_RA_Entry(struct adapter *padapter, u32 mac_id);
>   void set_sta_rate(struct adapter *padapter, struct sta_info *psta);
>   
> -unsigned int receive_disconnect(struct adapter *padapter,
> -				unsigned char *macaddr, unsigned short reason);
> +void receive_disconnect(struct adapter *padapter, unsigned char *macaddr, unsigned short reason);
>   
>   unsigned char get_highest_rate_idx(u32 mask);
>   int support_short_GI(struct adapter *padapter, struct HT_caps_element *caps);

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

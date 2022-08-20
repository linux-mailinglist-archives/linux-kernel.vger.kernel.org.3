Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0159AE56
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbiHTNEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346877AbiHTNEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:04:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096CF30F58
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:03:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 2so560887edx.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CIf1UQ7wZDxtwHlexp9HkgJf1IFsvLbw7syWYroias8=;
        b=qrRWr7v3lFQn1/6oFfneCHQ5v6efTvX/LCWg1MNaV09YcE2YYNmo7oOd87zq0PcirJ
         MD32ETYxBZ6c8DNusvjfieY506IFMBy9HTOaLbvpMiMTCXRcFkO92ugkbPBM20oqymGA
         2rqbOMC3qPEyK2HMlWeCOwbjUB92p9kZ1v5qECw87FrXF9SH55jNWwS38HPc4hYUO8+n
         OCdZPK7RK/LInpSfXY2WBpTbEp5eNOWI2BP/Ze/Ln6tU8UapYsP/u/HPQB4PWr9NyWxe
         GEylC8ACDz/ajSnrWODLr+bg8LllgCfOq6/8rE32wajF/FycyZjc7hflSiWySuBPptDh
         lPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CIf1UQ7wZDxtwHlexp9HkgJf1IFsvLbw7syWYroias8=;
        b=5LUd5IhehyBW1VPb2nzJx352ZcJtInwL8M4J5jjjO3OTWIGC5bNohOYqVRhEPkc2m4
         tSjjZiHX/EKmnjo3zB9Ho4J9IsiTbP3hMaV6Su0u5WDPlpXZqyyNfHQ4YLxf1VftJWiL
         iUGPuoqYibJ44tmSqrvcEvWkUBr5faBIHRwrb6H/Af7sxlKZi414IFqBw0r8qSW9SZ5O
         rqmPYhhooO0vFn0RXF/AWPkHACKI/XYplg0Y9vMeNNu3QpkeeiIkehSIpUTy6hp27Fsw
         U7gSxnoli2gtU4YJ7e11ndsSB/4cJ1YK36xTMdC1P+JD4vsWcSvBV/fHnZhQWocPq7LM
         dBKA==
X-Gm-Message-State: ACgBeo3Dlkr+UKHvvqIX2vOPMajVUdI70OQY+usaX/wtOoTBffsZWije
        ob3e49DsNw4e+V7G/TOxoaO5umTnIc4=
X-Google-Smtp-Source: AA6agR60GQbKpgmA5lfyLXzR41EMjfqjJuGBHfpk3A2xe9iyS2fLNGwaWEXiLCMkKurM5mgNYrl8Rw==
X-Received: by 2002:a05:6402:451:b0:446:7349:f9e8 with SMTP id p17-20020a056402045100b004467349f9e8mr2300969edw.180.1661000613620;
        Sat, 20 Aug 2022 06:03:33 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id eo10-20020a056402530a00b00445a06b6920sm4552605edb.17.2022.08.20.06.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 06:03:33 -0700 (PDT)
Message-ID: <481a3612-6f33-8584-8c71-aa62e98ab668@gmail.com>
Date:   Sat, 20 Aug 2022 15:03:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: remove ioctl_cfg80211.h
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        phil@philpotter.co.uk, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com
References: <20220818195454.11822-1-namcaov@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220818195454.11822-1-namcaov@gmail.com>
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

On 8/18/22 21:54, Nam Cao wrote:
> Remove header file ioctl_cfg80211.h because it is not used.
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>   .../staging/r8188eu/include/ioctl_cfg80211.h  | 89 -------------------
>   1 file changed, 89 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/include/ioctl_cfg80211.h
> 
> diff --git a/drivers/staging/r8188eu/include/ioctl_cfg80211.h b/drivers/staging/r8188eu/include/ioctl_cfg80211.h
> deleted file mode 100644
> index 738f645f9bbc..000000000000
> --- a/drivers/staging/r8188eu/include/ioctl_cfg80211.h
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> -/* Copyright(c) 2007 - 2011 Realtek Corporation. i*/
> -
> -#ifndef __IOCTL_CFG80211_H__
> -#define __IOCTL_CFG80211_H__
> -
> -struct rtw_wdev_invit_info {
> -	u8 token;
> -	u8 flags;
> -	u8 status;
> -	u8 req_op_ch;
> -	u8 rsp_op_ch;
> -};
> -
> -#define rtw_wdev_invit_info_init(invit_info) \
> -	do { \
> -		(invit_info)->token = 0; \
> -		(invit_info)->flags = 0x00; \
> -		(invit_info)->status = 0xff; \
> -		(invit_info)->req_op_ch = 0; \
> -		(invit_info)->rsp_op_ch = 0; \
> -	} while (0)
> -
> -struct rtw_wdev_priv {
> -	struct wireless_dev *rtw_wdev;
> -
> -	struct adapter *padapter;
> -
> -	struct cfg80211_scan_request *scan_request;
> -	spinlock_t scan_req_lock;
> -
> -	struct net_device *pmon_ndev;/* for monitor interface */
> -	char ifname_mon[IFNAMSIZ + 1]; /* name of monitor interface */
> -
> -	u8 p2p_enabled;
> -
> -	u8 provdisc_req_issued;
> -
> -	struct rtw_wdev_invit_info invit_info;
> -
> -	u8 bandroid_scan;
> -	bool block;
> -	bool power_mgmt;
> -};
> -
> -#define wdev_to_priv(w) ((struct rtw_wdev_priv *)(wdev_priv(w)))
> -
> -#define wiphy_to_wdev(x)				\
> -((struct wireless_dev *)(((struct rtw_wdev_priv *)wiphy_priv(x))->rtw_wdev))
> -
> -int rtw_wdev_alloc(struct adapter *padapter, struct device *dev);
> -void rtw_wdev_free(struct wireless_dev *wdev);
> -void rtw_wdev_unregister(struct wireless_dev *wdev);
> -
> -void rtw_cfg80211_init_wiphy(struct adapter *padapter);
> -
> -void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter);
> -
> -void rtw_cfg80211_indicate_connect(struct adapter *padapter);
> -void rtw_cfg80211_indicate_disconnect(struct adapter *padapter);
> -void rtw_cfg80211_indicate_scan_done(struct rtw_wdev_priv *pwdev_priv,
> -				     bool aborted);
> -
> -void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter,
> -				     u8 *pmgmt_frame, uint frame_len);
> -void rtw_cfg80211_indicate_sta_disassoc(struct adapter *padapter,
> -					unsigned char *da,
> -					unsigned short reason);
> -
> -void rtw_cfg80211_issue_p2p_provision_request(struct adapter *padapter,
> -					      const u8 *buf, size_t len);
> -void rtw_cfg80211_rx_p2p_action_public(struct adapter *padapter,
> -				       u8 *pmgmt_frame, uint frame_len);
> -void rtw_cfg80211_rx_action_p2p(struct adapter *padapter, u8 *pmgmt_frame,
> -				uint frame_len);
> -void rtw_cfg80211_rx_action(struct adapter *adapter, u8 *frame,
> -			    uint frame_len, const char *msg);
> -
> -int rtw_cfg80211_set_mgnt_wpsp2pie(struct net_device *net,
> -				   char *buf, int len, int type);
> -
> -bool rtw_cfg80211_pwr_mgmt(struct adapter *adapter);
> -
> -#define rtw_cfg80211_rx_mgmt(dev, freq, sig_dbm, buf, len, gfp)		\
> -	cfg80211_rx_mgmt(dev, freq, sig_dbm, buf, len, gfp)
> -#define rtw_cfg80211_send_rx_assoc(dev, bss, buf, len)			\
> -	cfg80211_send_rx_assoc(dev, bss, buf, len)
> -
> -#endif /* __IOCTL_CFG80211_H__ */

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

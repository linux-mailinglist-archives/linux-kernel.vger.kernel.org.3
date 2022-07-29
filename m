Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B39058560D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbiG2UWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2UWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:22:43 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED066A4AE;
        Fri, 29 Jul 2022 13:22:42 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id w185so5576887pfb.4;
        Fri, 29 Jul 2022 13:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QweBZid8fEFhqfcZZCVMDIwbgQR4peQaMt1LEKBD3lk=;
        b=UiMrZTuEKtgGfTXQyaowyOS2yqbsrCibOHwnEmJuIGilVkDOWt/jDaTux+wjNG1YJe
         wm72spLfS3nB7YWDhH4xW2T1ucK5HiOgWip+IAvC/TfkfJXs3dahcWMtP6t3sDuSW0o+
         wILkWVcFpYAjPTQQqO6VFFgQDYo+OfgJde/6yoNcDoRVGSpD4DJ8UPZ0PUORqJqP6laH
         wG3ytkUQMhIJMcO/+ynT35XUMG3wSdoP8anR6rIttVYuYysdINC0wUhqsdrybxFAVuAo
         OdrjT4Vk/6PuSWPcQlGaUADritTbAGZh29oMWe4piP2SSpUoFTlm7EQvHF/ywMuAoOAQ
         7+Hg==
X-Gm-Message-State: AJIora+E+yQGGinRs+DZ/foAx/ktN/QCxA2d0l7RpZ/X/3LI91KpPN4q
        Rf50qcSD+PdhFbpt/eYWaic=
X-Google-Smtp-Source: AGRyM1stJJWKFONHpzvtu8Pd/PlzvZa085Gc+IVl7btod8KAhfaG8SoHFGb1AVoPkN0XUIYsfX0RoQ==
X-Received: by 2002:a05:6a00:1307:b0:52c:62a6:686e with SMTP id j7-20020a056a00130700b0052c62a6686emr5047614pfu.24.1659126161944;
        Fri, 29 Jul 2022 13:22:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f090:7a49:3465:6a5? ([2620:15c:211:201:f090:7a49:3465:6a5])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090a1f0800b001f2fa5262d7sm3547204pja.14.2022.07.29.13.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 13:22:41 -0700 (PDT)
Message-ID: <01a30932-adae-a499-1194-57c925a3633f@acm.org>
Date:   Fri, 29 Jul 2022 13:22:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 2/6] scsi: ufs: wb: Change functions name and modify
 parameter name
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
 <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
 <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p7>
 <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 21:54, Jinyoung CHOI wrote:
> -static inline void ufshcd_wb_config(struct ufs_hba *hba)
> +static void ufshcd_wb_set_default_flags(struct ufs_hba *hba)

It is not clear to me why the new name is considered an improvement? The 
old name looks better to me. If you want to rename this function anyway, 
how about ufshcd_configure_wb()?

Thanks,

Bart.

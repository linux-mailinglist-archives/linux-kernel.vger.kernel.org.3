Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D584E45CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiCVSQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiCVSQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:16:17 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50759193C3;
        Tue, 22 Mar 2022 11:14:49 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id bi12so38084857ejb.3;
        Tue, 22 Mar 2022 11:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Vt2MdOIvO+8bb+Sz5q5lOmyC+uo7DuGX9AtMkx/1wOc=;
        b=B6m9purulAZyK7w+/eKZT0x6/XayzUZJyxt6MaVU7xPhKl2edRp9yfOAMfCn94niP+
         omHoiwbCWu+81YQ33Av/tDRztAZQSstwrZ54Xtz8Sx1vci/fAxY/+vcqSRPvNMjCXSx4
         Qmrs/tmnk+NYh27nd+Ilnzfa1Km4rxtbDuwITwsBBCv9F0DL8n/jXfMIiEwGrfYRUN3J
         +I3Enqj+1Kj6gteerqHpJcesi6LLDmpkTNz+h2fqdjiYyKWAaul0XnN5U+AChpaFa4KF
         5Ooo+KTEtXsI0EISDaTdmBacsEhPWLKeRKDsRccRSAUdTweKhGnb55QaPtpHyS7r0QrW
         JYVg==
X-Gm-Message-State: AOAM530nCfsQ1dri/X8pUQmosxjNdJLvBTu++Z48CzzBnA2njhsgjlsT
        3ahsPJxhxl3rD18JhB0iqNU=
X-Google-Smtp-Source: ABdhPJwvfxkUsLUDEMUk3Ex27al/N+zUIRbGoflNKTlVjZQhTaUURCK/BKEDch7RqueWAUDWMXi2RQ==
X-Received: by 2002:a17:906:d204:b0:6d6:df17:835e with SMTP id w4-20020a170906d20400b006d6df17835emr26366667ejz.20.1647972887741;
        Tue, 22 Mar 2022 11:14:47 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id j18-20020a170906535200b006e007fa9d0fsm3354554ejo.149.2022.03.22.11.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:14:47 -0700 (PDT)
Message-ID: <bd07c344-87cd-b64f-8418-d2b767a424b7@kernel.org>
Date:   Tue, 22 Mar 2022 19:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   'Krzysztof Kozlowski' <krzk@kernel.org>
Subject: Re: [PATCH v2] ufs: qcom: drop custom Android boot parameters
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        'Andy Gross' <agross@kernel.org>,
        'Bjorn Andersson' <bjorn.andersson@linaro.org>,
        'Avri Altman' <avri.altman@wdc.com>,
        "'James E.J. Bottomley'" <jejb@linux.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     'Amit Pundir' <amit.pundir@linaro.org>,
        'Luca Weiss' <luca.weiss@fairphone.com>,
        'Brian Masney' <bmasney@redhat.com>
References: <CGME20220321151913epcas5p45ad53c827e3c87633acd29443322d0b5@epcas5p4.samsung.com>
 <20220321151853.24138-1-krzk@kernel.org>
 <004d01d83d39$fe7859c0$fb690d40$@samsung.com>
In-Reply-To: <004d01d83d39$fe7859c0$fb690d40$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 16:40, Alim Akhtar wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
>> Sent: Monday, March 21, 2022 8:49 PM
>> To: Andy Gross <agross@kernel.org>; Bjorn Andersson
>> <bjorn.andersson@linaro.org>; Alim Akhtar <alim.akhtar@samsung.com>;
>> Avri Altman <avri.altman@wdc.com>; James E.J. Bottomley
>> <jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>;
>> linux-arm-msm@vger.kernel.org; linux-scsi@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>; Amit Pundir
>> <amit.pundir@linaro.org>; Luca Weiss <luca.weiss@fairphone.com>; Brian
>> Masney <bmasney@redhat.com>
>> Subject: [PATCH v2] ufs: qcom: drop custom Android boot parameters
>>
>> The QCOM UFS driver requires an androidboot.bootdevice command line
>> argument matching the UFS device name.  If the name is different, it
> refuses
>> to probe.  This androidboot.bootdevice is provided by stock/vendor (from an
>> Android-based device) bootloader.
>>
>> This does not make sense from Linux point of view.  Driver should be able
> to
>> boot regardless of bootloader.  Driver should not depend on some Android
>> custom environment data.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Tested-by: Amit Pundir <amit.pundir@linaro.org>
>> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
>> Reviewed-by: Brian Masney <bmasney@redhat.com>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>
> 
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Ah, sorry, I think I missed your Rb from v1.


Best regards,
Krzysztof

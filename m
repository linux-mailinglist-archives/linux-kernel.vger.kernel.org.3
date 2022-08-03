Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27FF589189
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiHCRfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiHCRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:35:27 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54E0BE38;
        Wed,  3 Aug 2022 10:35:25 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id f65so15716940pgc.12;
        Wed, 03 Aug 2022 10:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iSAJm2QvnWcgX+fcmSqiBDlAUPdacEOkQduvjbYvPK0=;
        b=qyE+o9OSDi5HYufNrnOWGvgE3z3NtfWhfBzb7sOhIhgoxuHxuPvWa6sgaCoNLXJZA2
         xTn6NX8LAyRNsZvXTzqgQ8OZIKfbtx3k1OQO6Xa7bNgjBpLFHxXZfdyTzbBB1akKETZI
         KdWZI/Lk1kvqr1yIDjKe+cbG9V5CHwkYbCmgQshsg76riWd1MyM2csauZrUCV06MibQT
         WfagW+WS0clFt3tK1FQFgbQvBGiQuaI1K+AdXrDMPMcqxye5w77IsoO6scD8bKX8BCDa
         mWNM6OKOB+A3e/tiISTeM2XOd8+eC+ALE71SE5BDTeQLRq1VRv2rNtbedpQx4pzFqoHR
         4Zkg==
X-Gm-Message-State: AJIora9LygC67vUIGKrkboHB+6nLozFBJ8RYRah4viLEMwZx7G/ZtUFG
        F1JjVTU8Cx4sHqAMDdkahPI=
X-Google-Smtp-Source: AGRyM1tU7SjkefLNKn0UoQWNOZTTqDrDTBYcIDdjRf0wk94WDDprXtLmXSfpx+9eIklcxWzxFHX43Q==
X-Received: by 2002:a63:f14c:0:b0:41a:b83d:a636 with SMTP id o12-20020a63f14c000000b0041ab83da636mr21790318pgk.361.1659548124823;
        Wed, 03 Aug 2022 10:35:24 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:db71:edb7:462a:44af? ([2620:15c:211:201:db71:edb7:462a:44af])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b0016efad0a63csm2269695plx.100.2022.08.03.10.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:35:23 -0700 (PDT)
Message-ID: <300c7d4f-5ea9-c506-2d3e-e1e053ed4f66@acm.org>
Date:   Wed, 3 Aug 2022 10:35:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 2/6] scsi: ufs: wb: Change functions name and modify
 parameter name
Content-Language: en-US
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
 <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p8>
 <20220802080530epcms2p8a9bb540dc6f21957148088b7a9b8b6f4@epcms2p8>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220802080530epcms2p8a9bb540dc6f21957148088b7a9b8b6f4@epcms2p8>
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

On 8/2/22 01:05, Jinyoung CHOI wrote:
> The parameter name of ufshcd_wb_toggle_flush_during_h8() has been changed
> in the same as other toggle functions.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

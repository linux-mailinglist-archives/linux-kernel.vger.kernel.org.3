Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB54B76D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242157AbiBORG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:06:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiBORG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:06:57 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69ABDE7D;
        Tue, 15 Feb 2022 09:06:47 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id i6so34013418pfc.9;
        Tue, 15 Feb 2022 09:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ps4k0Jak0iBO913tWS9Hiq43T0aZihvh+xceKKZ3IYA=;
        b=pI6V5aOQZJwQpWfGv22QTfmbUZnJfNxVbsWdrgiApPjTM6moeisz6zQGmrfCEQaibI
         4m3HtPXZYS15w/+ei5oHURT1i0GyR/rXUKnoOjwvDJx12GpDOo0jzZ9HVBQSJEY1xd7J
         bRTVtsW4/mZABaqApyNoy3zeHcexfAKPcKyTKdp715H5mHzYjYGvwEvoMvV3nl8pfsNp
         AfpQHlwXG/f/UE2YcbyAuzqnzZVEkifJEhI7b107h0URf+uP4lZNpv+IuKyrVo8zan05
         mfyYg9kjLXPDIlqsp/SX3U337FUaOupKzaRbkaNl+m195s7Yly+6dEiMdevJP7IRpsIf
         0bqQ==
X-Gm-Message-State: AOAM5314X/uLe64v6BGNep0iyy/Oob9rpWsLLfkdAjLEH8h81T7CKjFL
        pSvSkSvr5l53InO9jKmFyENnawUSFNgcmw==
X-Google-Smtp-Source: ABdhPJwrJrd2sw5Oa04ZMGxDcoI9uPlBf6SVwQVhl2Y5pUEBaRc22hjDs8f8FqooEPVoYdSkP52fFA==
X-Received: by 2002:a63:3285:: with SMTP id y127mr4363927pgy.32.1644944806602;
        Tue, 15 Feb 2022 09:06:46 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id f7sm3731669pfc.0.2022.02.15.09.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 09:06:45 -0800 (PST)
Message-ID: <a1d95bcc-2eb8-c038-8ca4-29dfa0c10f5f@acm.org>
Date:   Tue, 15 Feb 2022 09:06:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] scsi: ufs: Remove wlun_dev_to_hba()
Content-Language: en-US
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220215114002epcms2p1eb4e53507c96e0f24770af16aedcf5c6@epcms2p1>
 <1891546521.01644927481711.JavaMail.epsvc@epcpadp4>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1891546521.01644927481711.JavaMail.epsvc@epcpadp4>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2/15/22 03:40, Keoseong Park wrote:
> Commit edc0596cc04b ("scsi: ufs: core: Stop clearing UNIT ATTENTIONS")
> removed all callers of wlun_dev_to_hba(). Hence also remove the macro itself.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67277553598
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352622AbiFUPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352625AbiFUPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:12:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8982CDCA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:11:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso12851987pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TiJ5DaDZdRqbzKQOpoFsXYhvDE76Mk9e8wVqdRVoWeo=;
        b=EoXUiXZJm8qgTinLDSf4GBssv1ro8qAv3QSmdw5OMnK7hnKy/MPFmeUyiLaJk77nGf
         ppgI4+VNg/Lz9NCp632XtCtbkIyuBDnGgkxSIaJWlQhKLZMQm6anupH/0mZjBJpITAP4
         mw0t6wBaDsx+MLOB92dLDkQeBXtq9MzRgiHU+FRaTeIuS5lYx4zrzS5+krnmNMeV2cKT
         c/R9tZ783nX2iMhbsFzPwD8nq4rHyvnT/WFYM2Umuv9Wt5nutaPHUaFZIJ20pD9W8fT/
         RKFC9sNy4zwGXveU993MUnrHllkl1MGeHaYNRoa7/j4z9l9C2msGaSvloz2GhVGURQW9
         kJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TiJ5DaDZdRqbzKQOpoFsXYhvDE76Mk9e8wVqdRVoWeo=;
        b=124HmorAUryMQIHlorgWw+g2ryH3ILDL2DHNo4ik1Xdztt2ccp/cc4d/zdf3ckr1He
         Gbvlt6U9CDr03wFJjbi3mCBuVBXzL+6iqU9pzsJ9IoY/Jlzhsfxecpi7kGojNwA9wtCL
         52azgiXcPgDemFiNOYO8X47plav0+OaFdZxFskqhsAd/p4kWWg+M2tDINkhzn7krmFiC
         dcRyvE1ziaxlGtprQwU1rHHF44f6BJrxj/5u/58ogie6302i/IK2VG3q878tv4JIuF6t
         tm/5+7GR40+doAwT7F5UgUGy/O1DxS2L+QxwIbYp+k8NpnOz5EqbYcDiFXqRJcEnC8iv
         MQlQ==
X-Gm-Message-State: AJIora/qcWYYMT+jJ0Zk2XE82oIst2CgH7+RrnnoQmEJCo7niIHW6pf4
        xkV5Bhge8I7PIOzUlz0h6WE=
X-Google-Smtp-Source: AGRyM1vsi3VLkwPkdecQZMLXl+3TrUZ58QsgCWlY4+4A65dJh20ybjjO8pAvbxHN1BdfiPWWqQ/xsQ==
X-Received: by 2002:a17:902:bd81:b0:16a:14f:aab3 with SMTP id q1-20020a170902bd8100b0016a014faab3mr24845978pls.8.1655824301806;
        Tue, 21 Jun 2022 08:11:41 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:e884:dbae:d158:d600? ([2600:8802:b00:4a48:e884:dbae:d158:d600])
        by smtp.gmail.com with ESMTPSA id jb20-20020a170903259400b0016a13bd845csm6468162plb.165.2022.06.21.08.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 08:11:41 -0700 (PDT)
Message-ID: <ccadb3d9-97f5-cb0e-8f46-b83ae08a8e8b@gmail.com>
Date:   Tue, 21 Jun 2022 08:11:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] phy: phy-brcm-usb: drop unexpected word "the" in the
 comments
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>, alcooperx@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, kishon@ti.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20220621122401.115500-1-jiangjian@cdjrlc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220621122401.115500-1-jiangjian@cdjrlc.com>
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



On 6/21/2022 5:24 AM, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be dropped
> 
> file: ./drivers/phy/broadcom/phy-brcm-usb-init.c
> line: 864
>   * Make sure the the second and third memory controller
> changed to
>   * Make sure the second and third memory controller
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

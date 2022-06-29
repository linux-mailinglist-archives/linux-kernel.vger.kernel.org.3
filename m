Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4351B55F421
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiF2DZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiF2DYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:24:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5610B9FDD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:24:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k129so7103430wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=KE6saxt65ck9oabiR4Byg56CPLhDkMes8ZUAXrMKBkw=;
        b=NKW2ys7nbTvoxjDGsLq5OvosNQoYDwBGQju0Py6a7fUEZKrJ8+yirikFWnIB8Njh01
         MlMbG87lC7yxkVTQ0jqd6TFNxLWqfv4LAG8CtjHSei9lfD1laxhkNtSU65HSgIpCg/aN
         qiqa0Mh7iPS11kcs9OoQyY/V81lZF/wShcyWC3PDntEXbH8GiK9U4POFSduLRc5afU0q
         IWfpLbg9Basr8MSDn9U5Uw4r5hzqpdZKJkjaMA0Vp72Ptx/kX0nn3E/4ddvpsn+C3D7p
         s4YKaYaxF+H5v0WxLlCVQL6fDfhV4Dkj8VKepz6Y54Gn//Hsq9zpewyLy5/RWjgjr85k
         Pygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=KE6saxt65ck9oabiR4Byg56CPLhDkMes8ZUAXrMKBkw=;
        b=NAPSOjw0F7djP0nH0fefbRsA27NE7hTRH5FumKuaznblkdLYUgUWW8EL1WO+NDSjeE
         7GpCOifbRocjp1vOhwwSBrHB2YKoVLCBdL2bjmmwogHw0+7/Hs7xakLxAYWE4lp/T+sa
         JyAqOfShuqpOpy/1+fNst0gC8SfiIcNJmiZ6p+4ABcC7l37sx0FvLYnH4rPH9QJwDgrq
         8wHUIq9tdUgbRopW6SoS/2iHdycABjbzbxDUWQBI5sXFeXo8mmWKWr0wgI0VDafpsmcH
         O4LA8zoKMpgf1yGMHcXSWW6+ewaulyCTYm87Hx+y6EzhSwQdupmxqJCEUPjuBauWnerv
         tHzg==
X-Gm-Message-State: AJIora/z3JtEnDrZu0KuQraSB8PTnwn1FmF5z87eWNi/xxUqW650uwX2
        4TUdNI4d6PyiCRS0XSPva7MSByYg6Zg=
X-Google-Smtp-Source: AGRyM1vXy3K9NH/YPghiAE0s9tqKrUXTFm9gASlyzWQlE9b1oCmdDZ/DdjfwKMDNAEzHQ+uIKrw5FA==
X-Received: by 2002:a05:600c:509:b0:3a0:45d9:43e7 with SMTP id i9-20020a05600c050900b003a045d943e7mr1102970wmc.176.1656473085951;
        Tue, 28 Jun 2022 20:24:45 -0700 (PDT)
Received: from ?IPV6:2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd? ([2001:8a0:6cc5:7e01:9a40:bbff:fe12:c8fd])
        by smtp.gmail.com with ESMTPSA id z9-20020adfec89000000b0021b89f8662esm14941495wrn.13.2022.06.28.20.24.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 20:24:45 -0700 (PDT)
Message-ID: <75d51749-06d1-d2b3-8a22-ae72546a72c1@gmail.com>
Date:   Wed, 29 Jun 2022 04:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Andr=c3=a9_Coelho?= <andrealbergaria@gmail.com>
Subject: bits
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible that , the bits used by computers, are used as 
represention of what we want?


for example ..suppose arbitrary bits


100111111 ---> this correspond to mov 10,$eax


101111101 -> another instruction like xgh $eax,$ebx


like the bits are a representation of what we want?


andre  coelho


i want to get cc of answer to this


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55214DD979
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiCRMPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiCRMPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:15:31 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C100663B3;
        Fri, 18 Mar 2022 05:14:08 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id c15so11034192ljr.9;
        Fri, 18 Mar 2022 05:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tZ37tJK56cewZFP+PCmAXLvn4/qPNcqlTt1pFus54bk=;
        b=7f2OcHC/7pPVBvrbEALV+SYbDhPugytmbpNBNYxGmTzju1JaGP+U2JUc4x9vTmB8ax
         4bfpQ11PB+7p+MG3FcBbfXj0SEaLwjvX7QVQTBNn61TYwjLfzpplTQ6UusPvGPioP5U2
         zWLn2WwIJGiGnKW2sOoDTwk4zhmuGF9Iaq3V9bchVpDVSBMp706xZTg48VsRRk11KUR/
         XjIyI+gRASUE2nMB/5OuMd0P8FnjuQHCG7k6ovhxOucogKIQ9J+4OrCf5ZpSdZEmkCmj
         Q6hgcf+1J4/lgU0VexFD6z0zP1CmZddl43iHy3q9U58rc6ExnkcJnQ9wH9ZXyK+qgHzv
         LXdw==
X-Gm-Message-State: AOAM5301auXEchcxnpS46M9/NUHl2Fdud9Vqgl2M8PsNugWTztPga5j5
        O59+98VM+QUaKOWXl1jGys8=
X-Google-Smtp-Source: ABdhPJwD83A5KwpiXvrsnBf9XCuhj84aL5Xl+VgBoU1GrhMEfqkMrHLSH9hVjvRbytoNd98h7dyLTQ==
X-Received: by 2002:a2e:a7cd:0:b0:249:6bc6:7688 with SMTP id x13-20020a2ea7cd000000b002496bc67688mr2048325ljp.491.1647605646784;
        Fri, 18 Mar 2022 05:14:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id d12-20020ac241cc000000b004437eab8187sm825729lfi.73.2022.03.18.05.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 05:14:06 -0700 (PDT)
Message-ID: <57e516d4-68aa-44a6-4ea2-a7fdd4d9ed95@kernel.org>
Date:   Fri, 18 Mar 2022 13:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: imx8mp: add ddr controller node to support
 EDAC on imx8mp
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
References: <20220318113526.15986-1-sherry.sun@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318113526.15986-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 12:35, Sherry Sun wrote:
> i.MX8MP use synopsys V3.70a ddr controller IP, so add edac support
> for i.MX8MP based on "snps,ddrc-3.80a" synopsys edac driver.

One more point - I think it might be worth to add dedicated compatible
for v3.70, as it is clearly a different version (with fallback to v3.80a).


Best regards,
Krzysztof

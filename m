Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B644DDAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiCRNpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiCRNp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:45:28 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA57474610;
        Fri, 18 Mar 2022 06:44:09 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id bt26so14184817lfb.3;
        Fri, 18 Mar 2022 06:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+13Af56+e0RqW04Edcq76EyluIRDM9JaL8dIazHbckc=;
        b=sHP870PsI5Ncc0fJSlnvanQBunixb5WaRMDKSoCvpCd7ShpwxBJ3hLL/nQHwgTX/6v
         98bbtamJ2z9WjB5X5pfxoImIXbtgmNYXZYonElZFaGkyR7u7KqZmxTGCE/kpGL7CyAGC
         RX+tuB+Edt0VmX1uW897ATr5CU+w5pZ5MJtkbVBef869cLnpuDBKiYIckIY+G+W7ADxM
         GkkGRfiJYB+Kh2wtT/zgjko3X6c4LecZCFtZjQfsS3aE5Fytl+DWvkAfb4BDISbGls2q
         FAt3Zyz2+fOlyVjRKj2yoP8DaVtK4k6iuy3RazzPkzp2AD4kMJ8e9Z9nOxvSr8WUrEQT
         ij4w==
X-Gm-Message-State: AOAM533k+XW0sNliYf27LuwxMdwpfCi44kluLwBapzKMCfPreif61XoV
        DR7yvOsvRhPofcH+w2h7ygc=
X-Google-Smtp-Source: ABdhPJxBG0gMB7P6i31hX6URblEoIk15XK26/WiOk2L5XQrQkklk9dI2CS32ZTycPzHM2+9Bp954qg==
X-Received: by 2002:a05:6512:2613:b0:448:5164:689d with SMTP id bt19-20020a056512261300b004485164689dmr6030983lfb.526.1647611048126;
        Fri, 18 Mar 2022 06:44:08 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id y23-20020a2e95d7000000b00247e4e386aasm965319ljh.121.2022.03.18.06.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:44:07 -0700 (PDT)
Message-ID: <ad56b5bc-a9d4-b584-3c04-7c47995381f1@kernel.org>
Date:   Fri, 18 Mar 2022 14:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: Remove arch timer clocks
 property
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220317191527.96237-4-singh.kuldeep87k@gmail.com>
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

On 17/03/2022 20:15, Kuldeep Singh wrote:
> 
> Moreover, clocks also matches incorrectly with the regex pattern.
> Remove this entry altogether to fix it.
> 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'

Except of ongoing discussion, this paragraph is incorrect.  There is no
incorrect match of regex pattern. The field is simply not documented in
the bindings (not allowed by bindings). This paragraph is actually
confusing and misleading.


Best regards,
Krzysztof

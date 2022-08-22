Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E18B59C606
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiHVSXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiHVSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:22:58 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178047B97;
        Mon, 22 Aug 2022 11:22:57 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id v125so13234528oie.0;
        Mon, 22 Aug 2022 11:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0Qoldrnk1OOisFOprUKbgJfO+ztr4gzIbivup1sV7ig=;
        b=t+2EpcIV1uUS4QVlzbL43gyDj7JlL26Sotyp1vNgtp0uNb8JfGrvoUhOYsbzGP7yOe
         AWcyaof0/LMcz7KOE49uFyVxylKdqYzwVscoq5riPLvO7UzXRfGzcvmDQfaueljTt4X9
         uI6MDNyyq5T+0m7vEhoWOb55XJx0Zw8DuUhH8NSeu/8NGxcOZhxbCrtx3L0QzA/1hUv4
         +IdFGbk7xGXYOjx9TAHDHJ8C6ae54ezzaYY127yfuIHgcfzzMQXZJZ+83taHBsIR3vdQ
         o/px8BDoqpm18EusmS7uZsItX8xv8rQ3Bf5FngV720+/pnRtTM3pAZMuyJP3yypRfG7f
         QWtw==
X-Gm-Message-State: ACgBeo2yHWi09A5eAQZty0vuiOS/DykxAdqVoqO7FpZDn78fBloi5C6J
        62fAjPuSkKO+m5+WhIQlmQ==
X-Google-Smtp-Source: AA6agR6W2WOiZtmbA+066xdS7uLzllg7qZidjvvWBjMfuzyQ2cDQHRcW3NbhntdvtXkdXa+pc7crqQ==
X-Received: by 2002:aca:2110:0:b0:343:26cf:c6cf with SMTP id 16-20020aca2110000000b0034326cfc6cfmr12281154oiz.276.1661192576902;
        Mon, 22 Aug 2022 11:22:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g22-20020a056830161600b0063715f7eef8sm3025060otr.38.2022.08.22.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:22:56 -0700 (PDT)
Received: (nullmailer pid 107284 invoked by uid 1000);
        Mon, 22 Aug 2022 18:22:55 -0000
Date:   Mon, 22 Aug 2022 13:22:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gireesh.Hiremath@in.bosch.com
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        m.felsch@pengutronix.de, swboyd@chromium.org,
        fengping.yu@mediatek.com, y.oudjana@protonmail.com,
        rdunlap@infradead.org, colin.king@intel.com,
        sjoerd.simons@collabora.co.uk, VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH v3 3/3] dt-bindings: input: gpio-matrix-keypad: add
 reduced matrix keypad bindings definition
Message-ID: <20220822182255.GA97986-robh@kernel.org>
References: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
 <20220819065946.9572-3-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819065946.9572-3-Gireesh.Hiremath@in.bosch.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 06:59:46AM +0000, Gireesh.Hiremath@in.bosch.com wrote:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> Add binding definition for the support of the reduced matrix
> keypad driver.
> 
> Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> ---
>  .../bindings/input/gpio-matrix-keypad.txt     | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)

This needs to be converted to DT schema first for this level of change.

Rob

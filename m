Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3425564FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiGDIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiGDIXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:23:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69C9218A;
        Mon,  4 Jul 2022 01:23:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a13so14470861lfr.10;
        Mon, 04 Jul 2022 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=n1vhm4Wl4iimFulOuZcZFWhIlPBs6bOEY1MkMXme4Js=;
        b=muPVsZYTbJ9Qi68Ffmln3cgXa+gqWI5F1IVdjSOn1XgwqWafBa9njZmgk7+QMrVeBO
         x0ITb7ZwWEaD1wGVcSPL4B5ecYkwsXS+1OlBg/sA4GQKTJbi6QvZeOQHyu2gD7RGaq8P
         HVb+4s51sCnJIBdZ3iYUORpxNSG7oP5OnrIGhV6SbmGBI4xXQuBK3diMtIBysQOeL3WG
         Qrf1FmYTDGDaAEZOKW21QBBHBgHmyw4F/qJL6Ph7bq12RBVQ0jtUNBpr4bDhl7IPXjAJ
         88NxB/uC0HpKGysI+Sxcy2/rZJ6FBpYxIeUwGwjkrP39z84ve82kZlJWH8S8z+prw5qN
         SRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n1vhm4Wl4iimFulOuZcZFWhIlPBs6bOEY1MkMXme4Js=;
        b=JzwIUpgcjNAtaLHuklhjYdJs5JAmDlmGQda3lP0BHjtnad8VVeG+qCrP8e2ewIV6X+
         DrBWURJAF4sq1ZYKe5roYicCW+8cDu+CFURhd8dUeFPlguFjs1Ao8BoJA59/+alzR2Iv
         HPTyHyN/28gKMoy0LIOXVjO70F8/RcvPeQVIdaPitQWiR/L8zpZR0PTgXrYRx0xxnmpN
         kwCGQYruiysCDnBgZooYPAuA+GYXbodQDI/fAr7MihFXwwnWNFRBKwXOhXc213aKISi6
         /5hWS7VXmh6r4ufx1MS0DVEzL32qu2Wr2W/M/xV8H5pf/Bv/FT2lg3qpYua5NfEhzZfh
         S5XQ==
X-Gm-Message-State: AJIora+UhuTK1zcXAMVkBHIof4xXSSo2sgthWxYJl3gX3qC16rRieHEn
        RNf6JXs5hM9/3Ne5z9K1Ps9WX6FnuQg=
X-Google-Smtp-Source: AGRyM1utNVNM0dPFn6ZAtfoJvJjjRqYz7sEKSBfFxONbU/8xirIuD85yM9ESFUpG9cUyydShPvMUKg==
X-Received: by 2002:a05:6512:1149:b0:480:77ae:cdbe with SMTP id m9-20020a056512114900b0048077aecdbemr17585978lfg.604.1656922984143;
        Mon, 04 Jul 2022 01:23:04 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.119.232])
        by smtp.googlemail.com with ESMTPSA id v6-20020a05651203a600b0047fae90bfb4sm5033270lfp.56.2022.07.04.01.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 01:23:03 -0700 (PDT)
Message-ID: <7aacd99e-d33e-db6f-e84e-0951b172f5a7@gmail.com>
Date:   Mon, 4 Jul 2022 11:22:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15.06.2022 05:25, Julius Werner пишет:
> We need to be able to report the information that's currently encoded
> in the "jedec,lpddr2" binding separately for each channel+rank
> combination, and we need to be able to tell how many LPDDR chips are
> combined under a single memory channel.

Who and why needs that information?

To me it's not a very useful information without knowing how memory
ranges are mapped to the chips and then only kernel drivers should be
able to utilize that info in a meaningful way. What driver are we
talking about?

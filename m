Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8155B54E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiF0Cnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiF0Cnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:43:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F5B2BE5;
        Sun, 26 Jun 2022 19:43:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so7699654pfb.4;
        Sun, 26 Jun 2022 19:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=RXYOiN1ZRkDNUMdc6EvAB2KgoCOIpKk5DqqITbyH4Vm2P8rSvNhv9GnBqND274rhqK
         uEQKv//gzOUb9VEv/V8H4tq5ku32/hpJzNKhjlPVSLXGkTRuFszOKydarYHMgh9HeCyL
         YUjLPgikAFoMxMZuq+MbPb3K/W7CGyjllQWAa1r4GSc437jPi0AVKL96hrMwGK5GRZlF
         ZYAm/lPHrps4RRmF4HU0mMlZzqLxjDCmWdPINdBMIMnIffS2YyB4DOndO2qkm8m4lqtw
         ZMev55V+h13X3llJWzpTR5eyeCJFqdPXOwPZxjrsfoBsNDq8WLB9tHCp00HGV39lN5dC
         xRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7zPquDCtZyzOA5PY0kmGl8Aq5WV/QI7GoaYVVezsWQc=;
        b=5BvV1jkf9IXJiFlanWiqUF+r07eh0Qx1v4AF+3hDT6xVoydCnt3P5rVyFXWDYNGM8a
         0TD+Bbdgxm1X6QQT9xRMHTo+1fEPIj2fMSjPLcrOljE8LYcUU2qqyT1FcUWD5CrqsBN4
         NkUW5jGJVSc67/X20X7Tj8fsPctTWmJGTt2M9dIwTbtJ8c1oY5/KQD5++aS43Ehqe16D
         RNyEkqJ8uWR7B2jAYLis4kzyLj5xcdBpKae0Q7sOLx/zl6dWzOG+ldUV7XRSpZD9CGUj
         gIT+8XDJKmIRA+s7t+NaDtj8cxaVkT9sAjw+LqTgxwiRYQfUl9ARAQj8MKbFtMhHA742
         nkPQ==
X-Gm-Message-State: AJIora9IclGtfLgpTfZzZHqmUOIXeURXuDdZyG+Y88V1DuZuipy4jQSc
        grYVRJLbJEQxkqy0wjVyN4QdWJJNMPo=
X-Google-Smtp-Source: AGRyM1uxOY5c+2dolNZFaGjY0xMUlqUk6YWCBkPiq0IWdnBHfUD8ill9/ZeItAmTbEN/32/O4RXXlQ==
X-Received: by 2002:a63:5203:0:b0:40d:bf0c:d123 with SMTP id g3-20020a635203000000b0040dbf0cd123mr8462230pgb.287.1656297820946;
        Sun, 26 Jun 2022 19:43:40 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090341cc00b0016a6cd546d6sm5429307ple.251.2022.06.26.19.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 19:43:40 -0700 (PDT)
Message-ID: <9811d0e3-6c0d-6854-e654-4546fbe23860@gmail.com>
Date:   Mon, 27 Jun 2022 09:43:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Documentation: samsung-s3c24xx: Add blank line after SPDX
 directive
Content-Language: en-US
To:     linux-doc@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220614164506.6afd65a6@canb.auug.org.au>
 <20220614084658.509389-1-bagasdotme@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220614084658.509389-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SCC_BODY_SINGLE_WORD,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

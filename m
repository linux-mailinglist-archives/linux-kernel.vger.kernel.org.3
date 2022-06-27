Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5155C74A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiF0Hoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiF0Ho3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:44:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D26F60D1;
        Mon, 27 Jun 2022 00:44:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so8582300pjj.5;
        Mon, 27 Jun 2022 00:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tM23DjKii0UyrfYxqToXR++sx6Bv3c907PpEkNZJ2IA=;
        b=dI02UiK+96GyCjAy/y23ssTkiBgfOaHaN3IBGsga9xGkd+AyiW/G8NLimlhP7mDzid
         HF1FGWMcSKfmkcswYGRXowRE6oJqMTSYGc8tSfW9IZ+UK65cSlNRu7oZhimZFxjYcWgN
         YEITqrDuNYsxnkPCwk/dSJfr7zLztlakSD0jgnE4YdCBDqYcQkGb9Gqj8FVyCaIfaI34
         ARMWU7YQJtMVugDoK1W6lq+EfQCr553ew2IPWHC5lh6tOUr/fDMGIuLN4S9no0DfXbDq
         Ux4PvOcm6MKynLK7o5UzgKmMKCuj/7qhwxaLReQNzTEy3DJv+CsSK1FgOoTyph5IWfOp
         rF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tM23DjKii0UyrfYxqToXR++sx6Bv3c907PpEkNZJ2IA=;
        b=tXmj/jE/RqPM+mGdn9aVWbsw8fzV+pyriWZhphhe0zGv+/Y5dbsFVZngxDds2AIyEp
         j5k2jVLdDapeIMusmJ2wooLvKNDhHqxm2H0nMxEZAodIISGNcuZBFKc3kPoASZluqoSc
         GEmMP2nlzV5cOfRbDXvqDh6tgUDED6KLpkbNAILQmSfaFILX/b7hf/3yuSdQUFpvTrXL
         4lGc/UxEHcF/1U0JftTqjfvzWW/SUMvuAaZflA+FYJSyz1/aSAOjeJtC6qe0fvl7DIo2
         VySdEm3MC/EYNkIGVt7xhAegzVCCSbLEhMj0X3qg2uSXf3gkWRp8rTuHhKgN/4BBkPoq
         7TAQ==
X-Gm-Message-State: AJIora9c57TF4QCBm620gkEvH68rvPSGdm+2bhjTI5IFAOo0x0io8is4
        IiSuH3RS28mwWTRjQOAht5g=
X-Google-Smtp-Source: AGRyM1vpMa1Rx5ZotLVNR2KoNDFDjw+ICFL3zsLdYS5iFxlXhBb8hY4Utdd2KR9rEdRfYiOTahd6vA==
X-Received: by 2002:a17:902:e5c4:b0:16a:33e4:417b with SMTP id u4-20020a170902e5c400b0016a33e4417bmr13334640plf.133.1656315867831;
        Mon, 27 Jun 2022 00:44:27 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id bw11-20020a056a00408b00b00525184bad54sm6435642pfb.126.2022.06.27.00.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:44:27 -0700 (PDT)
Message-ID: <a87da917-29b7-3689-9130-bae042a4bccb@gmail.com>
Date:   Mon, 27 Jun 2022 14:44:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Documentation: samsung-s3c24xx: Add blank line after SPDX
 directive
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220614164506.6afd65a6@canb.auug.org.au>
 <20220614084658.509389-1-bagasdotme@gmail.com>
 <9811d0e3-6c0d-6854-e654-4546fbe23860@gmail.com> <YrldGaQFoNLcNgak@kroah.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YrldGaQFoNLcNgak@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 14:32, Greg Kroah-Hartman wrote:
> On Mon, Jun 27, 2022 at 09:43:35AM +0700, Bagas Sanjaya wrote:
>> ping
> 
> I see no context here :(

OK, will resend the patch.

-- 
An old man doll... just what I always wanted! - Clara

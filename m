Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45261595586
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiHPIqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiHPIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:46:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC511E905;
        Mon, 15 Aug 2022 23:51:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso4916444wmb.2;
        Mon, 15 Aug 2022 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=HO1hvzJrt6fDg2YVq9QTwNf9dFfBCNy/md641+Yjk6I=;
        b=YwlbdAMO/Qc5ZpyjymEZ1bBlLY7Bic5UxZaIcYKZIWVvN5wP4/jMObXSNj9ND8RdZ1
         WmMxpQ370Bzg4PXjik6DUxUYW20+0lXIk47su/jU5iIBx0XcjlQ/GzZPTK5cS5QNnGRV
         qAf5RicfYBk3lfJ4yLaeunT8zE0wedrx/vpX9tZQvC+z7Ub2hzhMAo6yiomgkE9jMKCN
         8yP4VwD5xOIcm7O89bWa2mkjMklvQa4ZwMemihKdFKxWyCtb5P7XeHV+E5IwXZZhFWXo
         nB3IoB7KcC+0Mhg5VuKw00RVLxvzJMqZXDi6f25B3iNTJ+eQ+eEVstCEUSWJyJ1UTYrK
         IYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=HO1hvzJrt6fDg2YVq9QTwNf9dFfBCNy/md641+Yjk6I=;
        b=6YtQFTi8fLGDks1cNRkfBcU4b9yQItdZt7CLEcCsmxcnFaezUW8TkP3gnnhDEBfXSj
         mOFhiAQb+T9C0yZV0WJWsc6xdt+MAa8cMNCiYupLJRuecrVDu1LMn5RJb66nrVkeaoSO
         kpQpZKSqLGynvOY4J8Ilqe6EXrQXV2UpztUlvb/8ws7t3CumTJfJvYTfuMSH1sAlcima
         INTAsvUqBIi313PZPy3oy3e5aXyVAl1tORqxZyrjbp9G+GRmRb2s6QkPhxLPZp1dPine
         iEC9hVx0Emfw32BYAXk6X+Ic9vCRNLaJWwLCrmbgCCO8xpsX4pdpqfrXpqkwg/wtmKpK
         XVGA==
X-Gm-Message-State: ACgBeo1bRLu3nVQKv2j9UwfFzIGxSn2jvaqtr+GROCi8OSVXDZozxoYI
        yFAKBFKuMJd3jVy10S273nb4EGujlKw=
X-Google-Smtp-Source: AA6agR7Oq24+tdDurQnNCccbjeuWM0Dt7d2QkbZt4EqxbrlZ5YG/QNA0L0smoB3oPi45RWuxNhdGAA==
X-Received: by 2002:a05:600c:4fc2:b0:3a5:c491:5ee1 with SMTP id o2-20020a05600c4fc200b003a5c4915ee1mr11846422wmq.62.1660632674889;
        Mon, 15 Aug 2022 23:51:14 -0700 (PDT)
Received: from gmail.com (195-38-113-253.pool.digikabel.hu. [195.38.113.253])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe7c2000000b002251abcba9bsm393261wrn.55.2022.08.15.23.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 23:51:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 16 Aug 2022 08:51:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: Re: [tip: x86/microcode] x86/microcode: Document the whole late
 loading problem
Message-ID: <Yvs+YG0eTBYm1kI9@gmail.com>
References: <20220813223825.3164861-2-ashok.raj@intel.com>
 <166059240569.401.7221163581479146132.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166059240569.401.7221163581479146132.tip-bot2@tip-bot2>
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Ashok Raj <tip-bot2@linutronix.de> wrote:

>  Builtin microcode
>  =================
>  
> @@ -134,7 +232,7 @@ This basically means, you have the following tree structure locally::
>    |   |-- 06-3a-09
>    ...
>  
> -so that the build system can find those files and integrate them into
> +So that the build system can find those files and integrate them into
>  the final kernel image. The early loader finds them and applies them.

Small nit: this capitalization change is spurious. The 'so' is a 
continuation of the sentence, not a separate sentence - now that paragraph 
is actively weird & grammatically incorrect, starting with a 'So'.

Maybe:

   ... so that the build system can find those files and integrate them into

Thanks,

	Ingo

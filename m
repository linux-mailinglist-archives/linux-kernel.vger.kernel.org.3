Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B953F9EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbiFGJgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbiFGJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:35:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E26BE64D7;
        Tue,  7 Jun 2022 02:35:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso3125270pjk.5;
        Tue, 07 Jun 2022 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/7EAFJgdonloPk0n/CJ/zciAeZ6ggjWIIfAJFu04Kc4=;
        b=S1qC8HOeFifIMvVV7Ym8+VedrgGuml+FLWbRZJtWYWp2ddutmxt1jZh9nW1uaFdcP9
         96r3gzbtnk3ex+h3r7BfV2K5VchL8Tx8o6sjpOAGg4EetIWYaBltqJDH29yt82KhuX6o
         N2gDEoVoKxGdXYw3GzlLTGTrv/D0yHGWcEV7QJPYASc3ccnGoVXNYLQTs378SsxriSRy
         VtvDsgfIMSF7B9piY1LNyOe4wK8iokWcZ5ZK/PgewvtfSxFqMgNm9YW+z9WJzsMEflT9
         hJif8d/zv3kDz7ETAE75U+2euTntkYJA8WGiCfh9k/Iq8CPyd8Kdb5fB+UiZdb3p4fu5
         9zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/7EAFJgdonloPk0n/CJ/zciAeZ6ggjWIIfAJFu04Kc4=;
        b=4DzfbDfBj11UgnKVmli5fzswFKrvbhvm/y931u+hyTi3TIAk8tb9OgFTsiuYnC9GcC
         l1etp8OYGrBxDo1iHbbW0chwtDRlDwY4rPlcEqmGcB4Yakq3kwpErc14dnwHqhYUs70R
         UzLMWAnYmqhicJq7vxwb4lwJTtndMDivC80QEWZ95MSpsFnQGs4S1hFRVnOKILAL0Whq
         YkfI3tsmDD2TA0ZgjDaRRuYxD2pjG5BgS+ApqdrZN2lEaL26oj2/PelUr8PmyKzKsaYH
         zDgQJn//DyDayqXh4z19V8nPwMM87SGsmC3ue87Rd4QqAosQxDzSPDDhW6xyQvDxg9KK
         IcJw==
X-Gm-Message-State: AOAM533EMk5piFz8zPU1nVH3OWRsOAJFtXsv8SjrjXmRhfi+0eEZNu5k
        jC0X1L03ZZvVPPXQK67kG3WQIWj3+lg=
X-Google-Smtp-Source: ABdhPJz6KP2YgSIRKs2hKh8e1UIylOlLROEWvw7Unv2OlluDBrIgSrrDYuWMc7+eJZ2wZ4C1CPEdUw==
X-Received: by 2002:a17:90a:2c0c:b0:1ea:14c0:f0ca with SMTP id m12-20020a17090a2c0c00b001ea14c0f0camr169736pjd.143.1654594515102;
        Tue, 07 Jun 2022 02:35:15 -0700 (PDT)
Received: from localhost (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id jg15-20020a17090326cf00b001640594376dsm12017207plb.183.2022.06.07.02.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:35:14 -0700 (PDT)
Date:   Tue, 7 Jun 2022 16:35:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: linux-next: build warnings after merge of the hwmon-staging tree
Message-ID: <Yp8bz4Yo45Bq4VfR@debian.me>
References: <20220607142301.3eb8a53c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607142301.3eb8a53c@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:23:01PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hwmon-staging tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> Documentation/hwmon/lm90.rst:493: WARNING: Bullet list ends without a blank line; unexpected unindent.
> Documentation/hwmon/lm90.rst:494: WARNING: Bullet list ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   7dd47c2603aa ("hwmon: (lm90) Support MAX1617 and LM84")
>

Hi Stephen,

These warnings above doesn't appear when doing htmldocs build using
Sphinx installed from pip on my system.

Cc-ing linux-doc list.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

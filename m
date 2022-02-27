Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26994C5EF4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiB0VAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiB0VAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:00:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E1932EF3;
        Sun, 27 Feb 2022 12:59:58 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id r13so21048835ejd.5;
        Sun, 27 Feb 2022 12:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HsbxMs8YWXLbNrp0FlklyOehGgNvH9xmK+gSlCK/Cz8=;
        b=qHDYuVGZR8koybF04aOtV3q2BloahUejQInSu46+wmA754cyMNmV5THRqIm4Uwbk1+
         rRprU3MDxnCzUS5KXJPcKyc3JRu13TqorcG2BEoFUk1ZfLoQ4vLkcchNfluTRHF+k/kX
         EkfVdw/ZBviyMdfe7Hn2HMSTmA+Wd+2LElrcFOuoFY/iwhKFDnjdTYSVvieAEI+peWU7
         8IO8f3RSvojYyYQQg84c4CF/MVfpkNZn47DG185PvAqu3wLLqmecilaGIoNasv8FStbO
         TW3ZZkfa9l22xjQJ+3luA/jstjxR9wSTZuodqlmuDQwjZs/1r3dJesNZGN7fpoNSOYdK
         robg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HsbxMs8YWXLbNrp0FlklyOehGgNvH9xmK+gSlCK/Cz8=;
        b=2JH2S42jRkhEa7DDYdpNJlosY8JMWlJhCznhI1eB+YMuVWXX7h4RSNa+18athYfW8J
         ORQJ0ebSr4SlEuapzbHQ3bwFq3Zkavi1/pxI/RksSE1Z6WKCBvAu8S0NUAf9nNHhCO9x
         nxW7ybss80lkCV9i6+MTjP89tSBkosFUcg2FP649rf0t6UfrggFeWChzKH6AYVlb32b+
         NztPGcaxO5rptI+vTPRsdo2DSK3oKrkzZpG1uSaVxHOSRzCajRqfgRB+z70IS19M7YTe
         XDqX/9nggpQpds+qxxfAFfYWulJlppvKVufJIQYWEYQVmZqRJw3XZ2iNy8JiAjpiS0t3
         iwuw==
X-Gm-Message-State: AOAM530w/J2XAS8KbtwVjzX23ce/fn3tESX9Sck2vtO4hrj3nxubyupj
        BkUooY0WIlVUDsEzYfHxwms=
X-Google-Smtp-Source: ABdhPJwCEhZZP4xVgVxCbFZmVcel5oOzCffL3oDmnl0u8Cch0C2URQ+sWn/bjcRooAdDU4rsvJVgKg==
X-Received: by 2002:a17:906:6d09:b0:6b9:2e0e:5bdd with SMTP id m9-20020a1709066d0900b006b92e0e5bddmr12532411ejr.246.1645995596931;
        Sun, 27 Feb 2022 12:59:56 -0800 (PST)
Received: from fedora ([95.180.24.23])
        by smtp.gmail.com with ESMTPSA id k18-20020a50ce52000000b0040f75ad0e60sm5205791edj.83.2022.02.27.12.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 12:59:56 -0800 (PST)
Date:   Sun, 27 Feb 2022 21:59:54 +0100
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Farbwerk 360
Message-ID: <YhvmSgQCiaIZdwsj@fedora>
References: <20220227203242.GA792093@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227203242.GA792093@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this definitely wasn't intended. Looks like VS Code decided
to reformat the code on its own - I'll switch to Kate for the time
being. This is hopefully fixed in v4.

Thanks,
Aleksa

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E685AF01A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiIFQQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbiIFQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:16:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C92BF4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:43:23 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 65so1528203pfx.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=pH9RKm/TPf2/OyVkyrRBJ6qM45HScECPbEnaj8lYNtL3zKeqCZDloJ5emwPC+JiaRl
         UI7ErAQFZmUNbD++WTaqyPy/GGKriOIy4FVaNu8D8sMHQRpBUTRY7NAIR/qxC6q0kIZ8
         1rYx+w9U1P7UXxqK+0A/7IsiNFrpSy4ng/NNADgbuxEFwIjWgWxvjm+Gezun9n2Ocjxg
         Wg4w2XHUfCO0Drt1RB3xikc+Y5InJ88Id86syf4dFILg73GIOKD2T3nO28TksLGtEZuu
         8YEnDjPQSBmnhikDsQNsf7FrQD5JlSQIGCJFdKsXAAH2YyM11fdoMoaoNNJeT6Vt0aXO
         RSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+D1zF2DCKf5WB+zgoPewh33B5r7wz0pan/6d9WW6hok=;
        b=vgdl738Zc7iQsKT4JWYkM1ltK9LgcPaJq/p6/WNeT5bNb1yp40jm2LdYKK3vqvv8z5
         6XoJIXDoixtR8DCem5b8DZnV9X6+IP2LaVR/uyw6gDZ6AkbML4p6GRuTnt9fBK9IcMUB
         cc/tbP+faBIYJuS9/KX7CVOyGyhgvr6ku1pBXwYNvSMZ7zfvQFcIciYOKZeA3CcQEW3k
         8jFZo6cpTkJrgwX1M5pl84TY6vW0WMBi+OgCgFgXduBeZ6O3t51DlWlK3y3vU9OUe6oF
         V9kWfb64X4O9NKM0I/dePlqwn2t8ih+QdWq7+oy8ZpuPJUgvshTTC6JbSQLd5CtumAog
         Pgmg==
X-Gm-Message-State: ACgBeo2vSBMVZp58sf3V2Shnk2GnS0Gy2XlUaO5THUUP3+aP/URPbsBc
        GLPjhPCCbX34MFZm8zs4IUT8Dbm8IeLhcqiEGRQ=
X-Google-Smtp-Source: AA6agR4jckI8m9urihs3H+eFjrNNGcOZGbauqbVP/aG2BFr68lkayOXI2HujjcX+HwK6xouWiLH2Zo5STQnKe09WCNU=
X-Received: by 2002:a65:6951:0:b0:42b:b13:b253 with SMTP id
 w17-20020a656951000000b0042b0b13b253mr48015492pgq.555.1662479002771; Tue, 06
 Sep 2022 08:43:22 -0700 (PDT)
MIME-Version: 1.0
Reply-To: edmondpamela60@gmail.com
Sender: donatus.brown656@gmail.com
Received: by 2002:a05:7022:525:b0:43:c66b:3f78 with HTTP; Tue, 6 Sep 2022
 08:43:22 -0700 (PDT)
From:   Pamela Edmond <edmondpamela60@gmail.com>
Date:   Tue, 6 Sep 2022 15:43:22 +0000
X-Google-Sender-Auth: JtYP_7YYSQJ3O5rMDoX2VUbVZj0
Message-ID: <CAGyz52Si7ySG0K6P5x7qm88+R4ckx6RustDLR1zGSH7L4gbeSg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon!

Recently I have forwarded you a necessary documentation.

Have you already seen it?

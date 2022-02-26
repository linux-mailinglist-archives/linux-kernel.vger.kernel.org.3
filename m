Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41A64C56A4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 16:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiBZPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 10:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiBZPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 10:38:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2096156
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:37:56 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id bq11so11407095edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=F+3NnrQ8DAHgxAhsYz7vVU9TGTMJeCect8eAZ4izxxyYZzVmRlfDomqJE1gqoSIb2w
         0B40AXngL+82L80aqDAVV6EChef2rAQYTRTlR56HZFjb2v91M9k9coz/fVId1K5GAaOO
         L95W+SH1wi0OQWJbIaoUxSlSxTMlASX8/ZfjUoF4D7TGYlmlLMX313VfM8ecxL2Ft7BW
         mU0960lmzNd2r+KqPAZSYynIDpwVrpe/xain6/PtyyO+WAphnhbbEXWrMCg68A4TfQ8H
         7UM+fR1zboCa+jFwpdR81XiZ81fO95w7F+1X2/OUO+flXmnX3yhM5c1jAId/k9D807cK
         dSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Q3blDFeENj1tDEE7bHffbGDJKmDjy25rOI20txdR3jI3m23pm44uRpuKm6bSSEakEr
         eweamKNQvlhubEQ/21jk55PwRqNWpSfXN/kXjCC5bVS6MRBhkV71yB6dTMfQVgK7rLkM
         ccv8lycM/X/GdrWy7+KL6rOAb5pDizbgnEPfjH4Cm/UyemlTux+TE59NaJN29ALit8QL
         egOsQ+9zfEd8N7N/RIKiYFwdx4SCfiC8asSRvZa0WpFnuqiCKzz0WxwkoKn2zhAkemdb
         2tXK4EqQY6KvIRTvAxjqqMT/Mm8mKyDkoPOJRJQKdqcPW7f91xggOoSb/Ou7FnoQXf/k
         mU5Q==
X-Gm-Message-State: AOAM530oFNAbkmK0lHz1BKPIubAuG8EmyogJ3MTkvxdUrGEtZ/grkSUU
        S0yiQ07aiqJNlKN9WVYaStpKoBkXnuAOvp0FBNc=
X-Google-Smtp-Source: ABdhPJxwYLlXpCPR4M5GN9nQ1Sz8qUFx/oHXc1Y7keurCbSZUtXeAkH6uz21iwk2AzssMKgvXhEKL1UX1jNJXWV9uOM=
X-Received: by 2002:a05:6402:2748:b0:408:c807:8db7 with SMTP id
 z8-20020a056402274800b00408c8078db7mr11752485edd.4.1645889875186; Sat, 26 Feb
 2022 07:37:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:3dcf:0:0:0:0:0 with HTTP; Sat, 26 Feb 2022 07:37:54
 -0800 (PST)
Reply-To: jessicaum734@gmail.com
From:   Jessica U Meir <ikezemakojo@gmail.com>
Date:   Sat, 26 Feb 2022 15:37:54 +0000
Message-ID: <CABzxHpDNq3wYQ5bVdVP1PBNSH20r-2nqcdo3tAUsOq+JVCamSA@mail.gmail.com>
Subject: =?UTF-8?B?w4luIGlzIMOtcnRhbSBuZWtlZCBlZ3kgZWzFkXrFkSDDvHplbmV0ZXQgMiBuYXBqYSwgZA==?=
        =?UTF-8?B?ZSBuZW0gdsOhbGFzem9sdMOhbCwgbWnDqXJ0Pw==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



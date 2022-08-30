Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C345A63F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiH3MxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiH3MxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:53:03 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE674377
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:53:00 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so15565018fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=Uv5EY4J4e31aqQAonhug3DaMcKELZms+6sfuARo9rzo=;
        b=fUJn6FGWWytaUd3MBZAUF/Xvs+UnQdKzEP3oMwv6377S6LDh26ydDEVz4uc1JGsA8n
         guGf98AMN+Kz/hv8c2ZM+3MJJOP5uaZZs86ykmA3Njrw9yKJUh5B+4R99r2jMI61gE8S
         pbusUU0fDmkneMQhovkl/paM9Bl/ZhTgSrHr3eNEyLHaNMmQOnZKNl3WskCh4APkaBzH
         J+A1zMVeYttc2dvqsQ/C5I0ZtUUTQNVD8Fnq7j3vEW05dc6MxzGOjTzq73V2h+68nffV
         E66eX70uxiUL0ZuineaWiIMCaPacHESZVq2Hz/qiP8Kuu1t1d+gxQMVU3C4vVmjh/c94
         yRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=Uv5EY4J4e31aqQAonhug3DaMcKELZms+6sfuARo9rzo=;
        b=xRJVloCqh+2695T6nzWbuWZVHIUfSnQlknVr5a7VR+y9ulzU25Utfg7MeI/mnWCpqL
         kmVbSXcqdhvDOwS8cxigLqZPyCNMfWiyGX5mJLSyuBLjqPa0Su3zwVfLtlqu7BAaHZtT
         8Fnouf0Pqilp3N2MkVi4cz0y1SPmKAyeWvTcXM4hKYRgEtgwDAqDJJ9W3XFytHu7Axdt
         RaPcBHZgEATG4+ww8WWGRZqre6k8gynNCDLH2tdEXi5jZgYQzgJ6YOXNYOGrHEcex/wq
         ciFltB2x8vL4ACy/qmYJj5B2m+rOVr1uaaHVbKG4HKIdqH8JMXV1POdF+M6x0xeH0EPi
         LZ7Q==
X-Gm-Message-State: ACgBeo1ft66964LgLkxxuH5lkePd8ulneaNDGTk+srWo4000jhAxANRa
        pwMEYMpVrJbluqRArlwcDHL/BbaELrU7NT6CXUk=
X-Google-Smtp-Source: AA6agR4oyiOP9d9EbWXzb2A4gg7uEsGcJ2cCngh5A5QZ1cUXgVkDet7i0Oka+cxj6jLm6GiLzXE7g7ANjLhym5cvpdo=
X-Received: by 2002:a05:6870:f5a9:b0:11d:cbad:301d with SMTP id
 eh41-20020a056870f5a900b0011dcbad301dmr9614741oab.202.1661863980048; Tue, 30
 Aug 2022 05:53:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:71a:0:0:0:0 with HTTP; Tue, 30 Aug 2022 05:52:59
 -0700 (PDT)
From:   "Phillip Maxwell." <phillipmaxwell12@gmail.com>
Date:   Tue, 30 Aug 2022 13:52:59 +0100
Message-ID: <CAH6BY-KDjNisyY+AgtbQmdso4RLDoJ_ZeTL1J5m-csHEfG=Ktw@mail.gmail.com>
Subject: INTERESTED INVESTMENT COLLABORATION
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Good day to you. I decided to contact you directly for the sake of
business collaboration. I represent a Research and Development
Department looking for a Supplier in your Country so that we can
invest heavily in a product. Please reply for further explanation.


Regards
Phillip Maxwell

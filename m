Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B655147F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiFTJiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbiFTJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:37:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE013DF5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:37:46 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cu16so14533644qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=qY7gu8YtTZxweTSpjNCkj53ezR/bpeffN15MCHzYdb9vuuiKCFSdu80S0px0q7XU5Z
         lbHzTJ9nW8Kkwa3BpagEtM/9MjqwzV6eS6TW3eVgDSGJoNv1hgTHgV8i8D8Jp5MNlIkx
         SIrrXh4Y6LsUPvkfV5B6bFTIGunW8Nk4OGs2PchnnMK9QnjRjnHO1yACBkxakFTzkESt
         O2IMJel3268EwD/FqT/hZ2/v3/C8lPMb8B+yqrzL0Igs29mpv0yffpJ0uRf7YrpeG5Vn
         HmMnDoK/O9OqjGPLg8jj1blOpqH7klSRJYCMVOJrslctm8wY4QP3S10blqGht/Vr9NbJ
         5qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=S3QTvAhEW4Ts9/o0Y4F08TCx1rDy3alJ81VYWGx06JblctyEA4+M/yrKuqDYUbf2Ts
         b7pIxow3H1/afj3MIvPnajbAFTw3XgRbYbWF4+3VUwPoxwuJs4047tzkMK5LamdRbQQh
         nyeng2KyDkhOy00GkkI3miNPgkxBVdFNqg/z3ksjEoP9SHzKzbJcNb2fDEdP/EEF21u/
         qmwVy/TfPyo0q98ejk3igaHaWQXYgr/ZvOFjnFk5v3fIjq/5wKvKTX+FZcflnAPkquHp
         Q31w3Kzrm6R7j4WSKIWXTHxzn+fi5aPBv9rAHlQq8bbEIA+Mp6dw5t4AcSQ2jygCqUmB
         0kFw==
X-Gm-Message-State: AJIora+gKGaBzipnAsagss/VbXDuNd/1ErHfTEn6qDsUMzNRl8OXCtj1
        gDNaTpLi5AiDShBGXE6Lc4QRCycYShbyXr5dcr4=
X-Google-Smtp-Source: AGRyM1saCA//1oWAM6tg4YpPNZKAYhKXDiXxBhih/tXzjIqub59UH6DFA9Wlcxu60+xxPnlNkU28dEWK9InnIC/5IUA=
X-Received: by 2002:ac8:5f0e:0:b0:305:1ae7:e318 with SMTP id
 x14-20020ac85f0e000000b003051ae7e318mr18743915qta.663.1655717865481; Mon, 20
 Jun 2022 02:37:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:27ef:0:0:0:0 with HTTP; Mon, 20 Jun 2022 02:37:45
 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   david <nenkan1975@gmail.com>
Date:   Mon, 20 Jun 2022 10:37:45 +0100
Message-ID: <CAFO9AXgNYFoGDt1E106Y-oL9StpeoLqy86nO7mhPhzU3UzMUXQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.

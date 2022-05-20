Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9627F52E7BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347171AbiETIih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240907AbiETIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:38:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD4A9D4C2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:38:33 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 27so3931837ljw.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=Zex5+q5YLrsKPzGo/B8e9Z2qXdTBYTX76sBqK1dxmdQ=;
        b=G8ART0cjcD9JYTtSw1vBir2RzM+0SwGvWqELXHisGitFqFEALJal8ERmOFqwwAlYS9
         eJfPV613kjYw6Ouz0ROaJ36DyfReaebV7M5kh9j2VFSGzXvYab7beO+vS8kMGKQeKmSf
         F3wplui0IRXUjRx0VLUN9ojsGufScNtcO95DXP7qjMRgI2wAqXUZDCo/NpzPterACN5E
         dHoUlSrCjncwy6eo2MhrA09ZkGaG1klGmdz2qwFCiy+pPpQwVYTT5QDg7TYwNAg2ElnS
         8RvInepBdIzaDxdKxtgNzdlm/KQcTbQPk2ti6cqK8vvimjFNZF2RBkG8ulv6P3zxHvh7
         zoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=Zex5+q5YLrsKPzGo/B8e9Z2qXdTBYTX76sBqK1dxmdQ=;
        b=6X3LgIsVvXsjLsugH7KIMOlYNthBxJDxu6BIWcsPbtMv1ey/9OLzcL5tJcwuZt0fH+
         izUQOKiKcOutQrhCdUbsfLSQHdpqL4A25DQ1nD62qikR7DcqgYFiMEaqlwIEEQiXQ/tW
         M4O0lwNuz+IwNPPha2XhX9t534h9CaMPnd1SCGVOmVwNuZrJefhlP1KEXaS7IAwQlO9Y
         X/yudeqs9IGfBAE3nmCPGp+88sdnT5bT6uocrM/2Vs8yUpfNq0CShFigSGoj4QGlLqpU
         JqagJvnQxH90Ifbxv7GFLpB0K0hBd+s/R2I1FN0DL0aHP/ZluKpmbNzrUrBKYt00T2fD
         PGwg==
X-Gm-Message-State: AOAM531fB0KfsHpd1XajwX78idcT6LZioF/KUHKxTH/hajqyDpdKYkbT
        iwt89JfhuCRu6x68TsBBptNpx8JDd18KXuINBL4=
X-Google-Smtp-Source: ABdhPJx2QM83IJHBXvkrCUOduBizslKc3L7HU2IKgaGfk6wIDWOZieVuVQDB3eimQaRZKgBWXItNxYhVxhEJbIcDK30=
X-Received: by 2002:a05:651c:1617:b0:247:fd84:2195 with SMTP id
 f23-20020a05651c161700b00247fd842195mr5022839ljq.356.1653035911464; Fri, 20
 May 2022 01:38:31 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylamanthey612@gmail.com
Sender: harrydaniel612@gmail.com
Received: by 2002:a05:6520:424f:b0:1d0:1b44:f9c with HTTP; Fri, 20 May 2022
 01:38:30 -0700 (PDT)
From:   Kayla Manthey <sgtkaylamanthey612@gmail.com>
Date:   Fri, 20 May 2022 08:38:30 +0000
X-Google-Sender-Auth: EmSC_VQcEszgESbyun8G0A9urpI
Message-ID: <CAA73Kv429wbJ4_J6MPwMNNDyRdPhGw2NCYszDykijCnDZA+7eQ@mail.gmail.com>
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

Hallo hoe gaat het? Ik hoop dat je goed bent. heb je mijn twee vorige
e-mails ontvangen? bevestig en antwoord mij.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1924B28B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351208AbiBKPGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:06:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbiBKPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:06:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C79FF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:06:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so11970157wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=Tu8ox6g7+e0/p+eW/EPRX3mC3AyEHh8QWbCgvjARWLAZPkHAYO64Fj2d/e7KaQ3ynv
         GlpUnK9uzqgshL1frzuw2LP2Sv/W6Eh7ozI3hFOaSWn7C5plFx9eYJOaf+zx8PlfZI0e
         cLfkxi6J8iYTjcoj5IN2AWeQrSn2ShU2MgCBW/v2NJUpUjLlNipxOwnBPEULLvwJ6h7B
         QrvFhZBZb7grK5p4SYdHctENOW4ESvXzd/uwL90ILbkJHyxw/ZqPw0jAUBK0erx+YdQT
         Gv1UW+9d7YtIb9hpopG2fUc6wU/BeAzx2rssqT++yYxEKzzWvqAsRBco3wRv8Pc/bOGb
         e+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=5AgZqWsw5nGPS00h7Fls9mAFbgUzlc8V/hQQtiFtwtVgG3O0lkIjWQlZ0jmOHiUOa2
         kvymaTh1pmXTuDfGpyob9P2kcSK3z6nuslS+YhJ6UhfDoB/YVYiNq4ybBJezpxZH5N3U
         a/iAp02NCqlMZDXVePe2ZK0lWcCcvmFFVCj26ltptUqGjOj3o10gQ/QEjkr0+RZfPm0u
         esqvR0b+Q6y7+0YFKskgw2zaAoIz0rECN8Snf+SERQawcBnwFHn+eL5UFuzy7xvbN+nW
         cpDiAwIWONbN7kJBzutzbnc/S8Bbd2ytgFKuf8j1YK0C+7oydtXS0FbOUCGDgpTbX/De
         BGSg==
X-Gm-Message-State: AOAM532CvBtqYfAP4BF7WkU016irPihkYbfyfcorl5+99n31WDFEuzj5
        LyGImnqPbhyZVNUs5/AoQlL/AaGX5Xk16NeROR4=
X-Google-Smtp-Source: ABdhPJycKI4HIbLW1klwhM/PaGlLnsP1dzPojB+w3kJFac5q3J4w02h+qqmV0DDvpW1zYjibhfhrgwpjVI9uUzyOc5Q=
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr1634732wrx.203.1644591993049;
 Fri, 11 Feb 2022 07:06:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:1687:0:0:0:0 with HTTP; Fri, 11 Feb 2022 07:06:32
 -0800 (PST)
Reply-To: davidnelson7702626@gmail.com
From:   dedi mark <dedi788877@gmail.com>
Date:   Fri, 11 Feb 2022 16:06:32 +0100
Message-ID: <CAF3O_y1NsWQGfv3G59MuHpfhUPfF+HXr0V4VbaC86yNUEMSfRw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
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

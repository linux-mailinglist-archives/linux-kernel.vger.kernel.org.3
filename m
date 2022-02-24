Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6345E4C2895
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiBXJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiBXJwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:52:30 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2BE5EBCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:51:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j15so2817873lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=psf797KL7dsDhIRHfoRaXtpDy0scThUk1Fh1FeEt0qA=;
        b=cmnwgtFZPg9HhxuI6CmGokzZlNkVMc0qkp9f2nr/IzrVHXWBVOtr8hBXvC4ZKQjNeN
         N7+svod8LrFnfpQ+E4nN172/xyqsJ3nkkFgNwdee+00sCbr/6vqAJyIsTgfC6NkqjyXG
         3rJpOCmZRh/xYjA+4VElwcoj6nmzQt1lAnRwYm5Hs2rBvEhQ6Acj5uGoL+iD3pPFTk98
         BDHnBHyiX0TgIqUgSo0JABJxivqmliHP4sXC0RL/a9Gppvzds0uKfRIxLrOgt4nU1REw
         pbTObMybgdc1oNolZjewqSphcL7ITgeCFd3Q278ysz2VesTCJjqrjmH451XZge112qlT
         zbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=psf797KL7dsDhIRHfoRaXtpDy0scThUk1Fh1FeEt0qA=;
        b=2peNy496hanwa/v916ulfAPMlrIlTxK3GIhU+BZLpBQOttzotQ+YjWA+89wGkoUlRo
         HDnJgIPSymgNk2E0WXv27c8MZ1/gY1ZDGZ95WCi+vuhZrte5wWeB6guR/Wo5RjTjzO9A
         Er2wdK2IqwUzJdoSpk9b1t9Zd8mVzEOnX9e8jWyLOUmSpwIVf0dt8DSXwwHvipA0LvGH
         dZSkZtUfZ7PVkGf7JuGs3CUNqI2iltiiOqWidnAGB1CbpjYn4u4syXojuFhqX7Goy/6A
         BYhyGM6aCK8OG6UC4Z5LEhRejf6r2X6tgkRujpROEk9uLDEFJBa/3MSLlq7JjM0I6x5K
         XnzA==
X-Gm-Message-State: AOAM531xMSSuPM/fLNu1E3IHMjiTZqixo6NECeMv9Mm6NOJkej6hWq1y
        sB9NM1G455DdzgdcW0uAmx9bYs4FoWShW8cN3N4=
X-Google-Smtp-Source: ABdhPJyZ0ouKSMYBqIwig+bjTPMLHvkJDCUcBQ1cNHD8EA/DBONQSvB7TQQQTBvMy9u3e9YhW9xHOFDH84G96809M8E=
X-Received: by 2002:a19:ee05:0:b0:443:f709:5a27 with SMTP id
 g5-20020a19ee05000000b00443f7095a27mr1277060lfb.399.1645696317963; Thu, 24
 Feb 2022 01:51:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac2:5543:0:0:0:0:0 with HTTP; Thu, 24 Feb 2022 01:51:57
 -0800 (PST)
Reply-To: ukofficeimf@gmail.com
From:   Imfoffice <jamesikpe85@gmail.com>
Date:   Thu, 24 Feb 2022 01:51:57 -0800
Message-ID: <CAA3hzmyYnoSMXL-T7Sb-UoQQmzaxVuM_HGOmd_nWzOeMLchAaw@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good Afternoon from UK,
How are you? we guess you're well, Our office has sent you a message
last week, did you read our notice? get back to us upon the receipt of
this mail.
Thank You,
Mr. Hennager James Craig

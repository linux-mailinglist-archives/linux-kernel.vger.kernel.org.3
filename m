Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3E84FAE0D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 15:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbiDJNoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 09:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiDJNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 09:44:22 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42B35418A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 06:42:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq30so9586641lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=Q10JEFEkof3O+4QMimrp5Pxh+cKzrurV6IU/mSbbVbL6AE8A/mdqDznE7FCw8uv4iM
         rvCmAU0FU7qIBUTlqFRfeG6hy/waS5Tk4UUAfxrrvr4H3zdHSv27EEwostqoeHQQAKAq
         cIy/2dZvsQNFuJM91NJ2G79Lo+UqYAJg8u/+cxT8N5QVrBVn1b5cdWBZAX6pOw8R6Bfp
         GyLvg0zyrXw412m5p9EJhVTrM7xWipSxBmKxxkrgR8MH2WvZJpCu/ldK41upWVXtLoR5
         hvDptKHe0KzGLrifYJgHiN8WLFcE6/QqJgQZMQ2dLOy5PNyh3oacHFSLI8Pt1BV30Qdz
         r5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=pUwI7NLX9KOYAdQq89miWKg18CI/Cuasgfvn5Eh9jXlqZU26jshUoHe7MbvpMjaRWJ
         jES2GIZbWHapb447LdU2FB6IBd5lTQd33HQ1i9puZ5oGnDQpcxil5/CPBZcb/0wE4oU0
         /AMUB9q3UKIdqN57HAFKSP3fdyRIowJj+YSh/7UFCwh5L/j197BVgc8tMENiHey8JdRb
         sYqJoOh84h6v8/SC2B0EQ3OldXbv79kPXIMDwrb7s7BTYuQPswjnEiWcmixnWp+FU+wd
         FvCvqGnlSRDr25DDizIyhd61l36+pcchxA23q+x6FdJRb9toF642kBor+PdQh/h/dEnl
         maUQ==
X-Gm-Message-State: AOAM532tlQL12rBeVVVGkUmzodbFzerWkTz1+K605hPLox2/Yt5GoCwH
        COvClXxFl55SxK+31gMWNhAgENVOckvyZQA9k+U=
X-Google-Smtp-Source: ABdhPJw9PSTfLiezUlMixRvspbapO2L+9UhC9o73liC8Jkz3COG5Tr5VyTD9kZzd4yhH834TcY/dci7GkVNl15syOWA=
X-Received: by 2002:a05:6512:3c98:b0:46b:9ef4:431b with SMTP id
 h24-20020a0565123c9800b0046b9ef4431bmr2821742lfv.52.1649598129985; Sun, 10
 Apr 2022 06:42:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:33c2:0:0:0:0 with HTTP; Sun, 10 Apr 2022 06:42:09
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgtkayla manthey <sgtkaylam20@gmail.com>
Date:   Sun, 10 Apr 2022 07:42:09 -0600
Message-ID: <CA+RGHE9DxGCTMyE5GxL4SX2cvKzn9HuvN9OJdOiKtSAiswhUJg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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

-- 
Greetings,
Please did you receive my previous message? Write me back

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB0550DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237526AbiFTAe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiFTAez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:34:55 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DA2B1D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:34:54 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-101bb9275bcso7510948fac.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=J7hkcJ3uceOP+IKzvXE/C39HgmXyn/Ufc6skBYS5jRX70ZD8DPRtujYtnf5B8JWoUp
         H2RPhpa2yoIeCwfFLAaN9Vn3EaI4qaip04B0DduVX+Svp6O9n8sWX9mk56KEwwodLq4K
         8Mi2SaThKlY/2D/up8J4M0OvLl7Mr2v+MCXbgb+icsXeBdax1xOYTUgRoc5Fqjl6lKxe
         E4oOErk3jZPPpxy6oI71b63hqweixGnKsod86Tt636V34CGDlVZo1svOID/SjN0lzJYB
         CFhK3uSCorPwiVURlOa3KDxCKvJAalswfWXXtmcPoCYXijqC5Xio+wp70Np06TqEtxzr
         Nzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=h5G/T/rrNG5kn7ti7CngTpYzGTELSLwtPjCcUYhUNaw7FRibQQ9rj9+VBO3/Sf/cX2
         KctNlQX0XLi5wcKfLOn3Oh4pnEXmtVj5m2QU3Ro7mR3mn2Xvm001Drpn82O4OGIL3BEs
         sSe0YllDHrPrT6TFaKCL9AjrT7DOWO5gV7tJ1O5lnaQXhSspQK7OCZFORDJ/WpNubNOv
         lKzVqUw8ATFZgghHfvrTCQycMeY1norgzBa2RXr8x0uIHTHg/2lTKSK4T+PfH4k1wsuA
         QafSbDQVi7nB7QT13J1E3TBojWCJkyCjqFc9aXWRfPXVgDW3IzfZAY3xWtNHDspMZ6nm
         I/2g==
X-Gm-Message-State: AJIora8+3bvE5pvn1kQuVbKPpLyetKl9FbOS0VNHP3YFOwZsJgnr4wj1
        YBU+V/3CgxZaz6gFszupk81JyG3o1Cng4l+2Dnc=
X-Google-Smtp-Source: AGRyM1uSH89N4TgR0IXuhjk1zDI2c++4D6cjwfc5HvRLFjSR9hle85yRv3PmtXN3HOgoUCJnMhYUm9BtuAzPQe8wN60=
X-Received: by 2002:a05:6871:b0f:b0:f3:3687:524b with SMTP id
 fq15-20020a0568710b0f00b000f33687524bmr11002464oab.131.1655685293346; Sun, 19
 Jun 2022 17:34:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:7e82:b0:a1:cca8:2804 with HTTP; Sun, 19 Jun 2022
 17:34:53 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <siredmondnton@gmail.com>
Date:   Mon, 20 Jun 2022 08:34:53 +0800
Message-ID: <CADN_UKpcUJmmbE3CYsusf9S-PEhgROT_i0nvKY=KK105ypFQYQ@mail.gmail.com>
Subject: services
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can I engage your services?

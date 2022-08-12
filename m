Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF51F591608
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiHLTlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbiHLTlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:41:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F3B284C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:41:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l4so2169214wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc;
        bh=Iq/5xRoUiwhIFx5/vJDa4DTExyHthpSWn/1B/QHBuX8=;
        b=kPsTgBeX9cktKrXNkL/lPRmjzfAy4L6XD79mQmQG95/00rEk+ceM3GIn4BgNva38hg
         amUDp2pkk6KTBKklZzBmhq3a833FiUIfLr68tYN8bqJ73UZbCacqTMmc1q41irSUPPHv
         AhHuuw+LV+MiPtKSneGmZ6qWXS+1E7a/8hgazVTRHxk5jcSjaguDUBylbsrgybIH685R
         0hA3gK1l7201GHKEBLPIC6zeZzBqqL1Eu3/V529Q2pR6EjALlleAzg15z/+dBhpKNs/7
         xZfFKycaDbcDdlL/Ivv88WYV0K+poyzmg7JTSWHk7IsjkmRHzZqz0SP2qGp3bZ+ZsVLL
         opwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc;
        bh=Iq/5xRoUiwhIFx5/vJDa4DTExyHthpSWn/1B/QHBuX8=;
        b=p+bvwF6RzgGMVXNhaGoQFxGCUuouKVcAU0UuPlVt9hjQj+U+iz4c6LhZ2EeA02FuzV
         W3/dZ6iHF3UD8ltHCIzA6WwMtA0+xqeC91A2/uHv/p1uVM1MHWqYdp1ABJezUxVDw19S
         CL8aRMeV76TkHo+NvxPKRzGZk127yU6XtCUERUlKAaN7CwW6dw1upAO9WaH5dnhQ2ZIa
         I4xKeMRhAitchsteNXUZYbRqRPzzJL0vA2poGE1tCZ6mDdl29xCMRtL7cfgaW7F11A4A
         gNgg2W+UE5g6MqEFXB5aqOr9+wK+/Di1uXoX+iRTaJxgttz2GC2dJImi5yqGyTuoZvFu
         lTTg==
X-Gm-Message-State: ACgBeo1GM+3t1EgNY8p4WiweHF7F0W7dirc6pt4rAqSi4IrCWokWNcjB
        r+0BIvmuI5FnV7XMJPsg0/L9AnVJU9QgnfL23sQ=
X-Google-Smtp-Source: AA6agR6x8ZPS33iAOgnu0Fc+ZWMdxOzvR4UNIdN9rN7SItiJdCgqQRnZcoqtuA5Q5vjzl9hwIbmQRg==
X-Received: by 2002:a05:6000:10d1:b0:220:5c89:50e5 with SMTP id b17-20020a05600010d100b002205c8950e5mr2999111wrx.335.1660333305255;
        Fri, 12 Aug 2022 12:41:45 -0700 (PDT)
Received: from localhost ([84.255.184.228])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c2e4800b003a3561d4f3fsm384771wmf.43.2022.08.12.12.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 12:41:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 Aug 2022 22:41:35 +0300
Message-Id: <CM4B165JCMGL.1LA0ST6YL7QAS@Arch-Desktop>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "paskripkin@gmail.com" <paskripkin@gmail.com>,
        "syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com" 
        <syzbot+e3563f0c94e188366dbb@syzkaller.appspotmail.com>,
        "Greg KH" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: n_gsm: fix missing assignment of gsm->receive() in
 gsmld_attach_gsm()
From:   "Mazin Al Haddad" <mazinalhaddad05@gmail.com>
X-Mailer: aerc 0.11.0-85-g6b1afc3ae3d8
References: <DB9PR10MB58813E33D3516BAB526156B1E0659@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB58813E33D3516BAB526156B1E0659@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 10, 2022 at 12:08 PM +03, Starke, Daniel wrote:
> > Fix this by setting the gsm->receive() function when the line=20
> > discipline is being attached to the terminal device, inside=20
> > gsmld_attach_gsm(). This will guarantee that the function is assigned=
=20
> > and a call to TIOCSTI, which calls gsmld_receive_buf(), will not
> > reference a null pointer.
>
> In my opinion there are only two possible ways to fix this:
> a) Move the gsm->receive initialization from gsm_activate_mux() to
> gsmld_attach_gsm().
> b) Avoid calling gsm->receive in gsmld_receive_buf() if not initialized.
>
> The current code might assume that gsm->receive is only called after MUX
> activation. Therefore, variant a) may break the code in other places.
> I see no need to initialize gsm->receive in gsm_activate_mux() and
> gsmld_attach_gsm().

Thanks for the feedback! I will send a v2 patch that implements a check
shortly.=20

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382814B883B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiBPMxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:53:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiBPMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:53:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3431D684C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:52:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x5so3702316edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=RUm+BHjHjBqeaGuCk1BVfImjY9k8WWn0rEUOHAWVbOo=;
        b=YzbHrrMa0qaR8llzkr+YBtGW1+880XxFVVRnWA0wd7OV/CvRfUDxZmLR45E6JhQmqh
         j1vmID+nO+1VAVAvQPQU9sCKpsfuyCISFspw7ax0NhqFggkbpmD6g2McJwWHj5PTsr8t
         j9hmHkTCj9tv3ZLnPzlTwzsR4RgHpNdzvb7vFofTNMHCANasK3HJbozEOn+/yBd6UDnA
         z4WsJD4GUFnX+ds0DEYTPs0SjjsInHTpziEmk/2RT2QfHwi6QEjBvxrLQ/1PmES57mre
         XDonhfaxKUcp/n1a70GuKUjgsEVDKs6EuiEXv+l99jqkMx+dUew6yuR5VrpiijzoO83B
         +X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=RUm+BHjHjBqeaGuCk1BVfImjY9k8WWn0rEUOHAWVbOo=;
        b=LqdHVpFSjX9eex1Fe4DddUmlzRs/p+rJlphjA8Hh3LsUeOdoj3Z0fKU67tc0WjLSYm
         lLgKpfha58TMifOoJKJTsM+fGo3S8XHK5oHjaIctnQWhf0xx0k3JxGJrUaF2Dp55dKIt
         4hcxAEkGo+LKOz1N2DBqyNfChIJUoMahiknlF4nvQHcSnpNjV+qN80Zvd9V4CakIgzWg
         hfoy1DASK7ufYlh1O2ZXaH5CKMLAKKLUMkaCPZZA9O3VdF9v0v3fESSQXVDHWukdUzU7
         wqw9xLvI8pKUKJWXki0E/U0C+8/RPicS1FksEt8mCc3364zcd8ppqYwNWasM28WOZYNH
         5vAg==
X-Gm-Message-State: AOAM531qzNdfXBM02s+zzpLNu6dX1sZXRHngoOy76lsuNAcZhP8kU0ab
        C7uYO03prBIg13TChDUlRs+SlGYjjTsNR5Tjjhc=
X-Google-Smtp-Source: ABdhPJyrEngpqxOOVGjhZxSVWeboC4pONMbigYypZ4EjuFscMCbs2Tm3GSolBdF/X9Q12R8adkASYznMO8dcBBUJn3k=
X-Received: by 2002:a05:6402:354f:b0:410:fe90:f77a with SMTP id
 f15-20020a056402354f00b00410fe90f77amr2855914edd.86.1645015937904; Wed, 16
 Feb 2022 04:52:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:6d12:0:0:0:0 with HTTP; Wed, 16 Feb 2022 04:52:16
 -0800 (PST)
Reply-To: michellegoodman035@gmail.com
From:   michelle goodman <goodmanmichelle700@gmail.com>
Date:   Wed, 16 Feb 2022 12:52:16 +0000
Message-ID: <CAL=4yxecaEBTCtd2Q=P52khGLXgGLRYsSndBUq5x0BHCQg8bJA@mail.gmail.com>
Subject: Halllo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4779]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman035[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [goodmanmichelle700[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [goodmanmichelle700[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten
Danke.
Michelle

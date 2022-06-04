Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C997653D64D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiFDJuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiFDJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:50:15 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F5F120AF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 02:50:14 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-30ec2aa3b6cso103086897b3.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=KlFFfMPlRK8Vy4FYjFs7iZMXm4h5d8X53tYtT4+dKQbR2esjTfqDkalnCMmyVA3TfC
         oVqXVYMBI+DqlBW11LVIrwTjdet3k8hABjd8zz8h7TDwGM+72+T/HGLubEhKST4Rc32h
         zD4qU7q9P0hwVcT1Mb0hAXoyBfLVyfkw3bRGxdUl9dIWEBEMot4eED+gW63rumjQI1/3
         dSVSjIjWhBXi+T/1HeO4Abdgdwaw5vWovHqm/ca8X0taFa4y1mw+/SdqORwbbxEprwjx
         SRqyg83xhSRcdULvwzHAkR7xxp1TK1ldfrtYmXX0lJgjr3+nn+t0jpEx0KaOqIJW3CSz
         umaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=1JyLO+fh+8aU+YTgaVtVt3vNZG5NdO0OFmZ5hbd7w/iQVU8/x++UFqaXCoQTH5g7zV
         AdnHiPKb4s9rnTORSjxYNwBPgiwzVTCH+Ec5yFmPhc8PSV+AotFY0sRYhrFVww6TiFuY
         YF+IWSE66vVwgyn4x2qkAFYjffBibDtxMYZyiIdAYvAeCPKqlWfAAag20w/YC8w68x+S
         PrVYiThAdoF9v23DmXfZl7ch32fQddMJrHKz+4R6McxO4B0hRbF9xG24OqEOSoS3dU66
         520FpEa9qG3Y7ldB27U7nc33VhBesjkBNVAgKyQxxDSnX9mnQTxPDlC0KSFSj5+CPP5s
         tb3Q==
X-Gm-Message-State: AOAM531qDaUPU1A4XvnFktwZ+edURC0hqCvrObeRApw7+wWvwEdG2RYj
        kbddL6gzuwG+BsqBujxEc8RBTXwMJ77WrJLOYkI=
X-Google-Smtp-Source: ABdhPJzzwufeKcOUW5IBuyKIGuDl3rufy4hl+/COD43DbbPyhapGZKvDOYo6oqYpdFE7/mLy2ibIV+SJ2jhF+FlGIaE=
X-Received: by 2002:a81:be05:0:b0:2e5:6c26:59fb with SMTP id
 i5-20020a81be05000000b002e56c2659fbmr16184600ywn.94.1654336213302; Sat, 04
 Jun 2022 02:50:13 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: abusalim078@gmail.com
Received: by 2002:a05:7110:334a:b0:181:51b4:c370 with HTTP; Sat, 4 Jun 2022
 02:50:12 -0700 (PDT)
From:   Zahiri Keen <zahirikeen789@gmail.com>
Date:   Sat, 4 Jun 2022 09:50:12 +0000
X-Google-Sender-Auth: aSHKD4cmJEuaoIfuw3jqcb3hxJc
Message-ID: <CAH0O5dHh0SeUb-dnezs2a71xZd7_vMycyDHMsiBqzvbteoKUJA@mail.gmail.com>
Subject: Good day to you,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri

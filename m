Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27FF4D8C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244070AbiCNTl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiCNTl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:41:26 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9793C727
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:40:16 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id z10so7066495uaa.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=guCX3nepl02itBKERgjQxl7FRNYnFxACGK874K3emrE=;
        b=Fj+VO0VE6gpgSlruSTL1zv09M3nNgGEpH5dRIzVwNjGKv8MjbIttxCimCrjuoaMevf
         DPyXIyavf35LjxaJRvO+GBwKy5WWNcZe3B51wVfTIknXAElwXowyAyAdFxmRHSJICDoc
         9DFNP6Pl19q5BtgmrO1WEXu849Rgrcz34UMHPJ/7K0ZO/WzUfW1nb0LwLXRmujtvwDJ/
         8mh5lH5aIVLkUtENDF9KUYLhBdqDBK//WX3+Mr8AJKO7INWoYcGwTcOVKE8Sx0iz5zzQ
         +Z7KF8PMZzhlWYUrlFqfhh//QMq9piRYZvuNwjb5qCuQbGGl74NL2JfD22P07qPpIy5P
         19IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=guCX3nepl02itBKERgjQxl7FRNYnFxACGK874K3emrE=;
        b=Hn+DroYcuqMsDon/WG9PF9aerylNKY67+uQE2Cr7ph2hwVTtkBk+PGzLyBWYVNpJa6
         lTg/jgPPXk4AGyWX4lXu/dIARfuXylXoPbZSNPX3o4qEj4vq1gWNszRbHMyS7s4hd1ab
         jTKRh26NCmdbCNitRoZ4JzALy2tRnSKhSbB5lHwrYkfzX8NIb8ZzuK1MX+M5i0FM6yVd
         mNsFB8eDhZPPgbTF/IBjJ1YC+dTAC7R0Nsr1oFtiwuzu/ogIY/fZJ+r5RaQ877y9uOCf
         TEFdd64WGotvfVQlg8iv3TEgI+baGCLxc0UrlOIPdvClorb2UqW5uf3+DUSjktup/nUx
         GY1Q==
X-Gm-Message-State: AOAM530BgQU4hiErZkE+eQQvOlAIP7l5mwc8Xg+7yOI4ZO/Cdu24KRm5
        Y+Uw+Q9dYolbC++p3Y+3hYh39Js9jxGiXDYsSbg=
X-Google-Smtp-Source: ABdhPJxbPX205fH+LcJJubXq3Oyu9UCp+9JhYObNMAN+dtxS3KjMfUBEMg2legQQjUQLP222EcTD9zclt8C98LT+q0o=
X-Received: by 2002:ab0:546:0:b0:34c:3f39:4cb6 with SMTP id
 64-20020ab00546000000b0034c3f394cb6mr9642190uax.31.1647286814144; Mon, 14 Mar
 2022 12:40:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d6c4:0:b0:299:f3b0:5679 with HTTP; Mon, 14 Mar 2022
 12:40:13 -0700 (PDT)
Reply-To: clmloans9@gmail.com
From:   MR ANTHONY EDWARD <okoriemartins632@gmail.com>
Date:   Mon, 14 Mar 2022 20:40:13 +0100
Message-ID: <CAFgZtcc=jSQUEN-pZHYw_t85UEULPeDCsiT_uXtrC_Oyk=G3Vg@mail.gmail.com>
Subject: DARLEHENSANGEBOT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:92f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [clmloans9[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [okoriemartins632[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [okoriemartins632[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hallo

Ben=C3=B6tigen Sie finanzielle Hilfe? Wir bieten Darlehen zu einem
niedrigen Zinssatz von 2% an. Wenn Sie an irgendeiner Art von Darlehen
interessiert sind, kontaktieren Sie uns mit den untenstehenden Angaben
f=C3=BCr weitere Einzelheiten.

Vollst=C3=A4ndiger Name:
Land:Germany
Ben=C3=B6tigte Menge:
Dauer:
Handynummer:

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4587A53BBF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiFBP5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiFBP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:56:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690A42A71D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:56:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e24so5333168pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DXdJtM2a59ym6M9TdEfmByz4F4Czr+WXnlJYPlHgUlo=;
        b=SH70HHPjC966gsopPP46ddg1ZFNbcj/ox6lkkCCqaauFTg5n3nau3eVX4KoUDLbMgb
         TD64nmfn8QuirIZecwfBRkYZuJLyK+XCPNsLULpk03q/OJo62gu9xzy7vS5rRwadbyQm
         UyFFPZLZPgzcJZCkYjrtj5RTzn0dTHZ2Y2Al5u6CMlhb6QN8HAul/yLHB3l1VDDVjpKM
         CxQxVcwjAt9FfR7ZIw7a9EE43I/a6NCnSDa/Foon0STHykHQnNd8oP1k30sb0C8kbQAQ
         43seGAjM7XDxZlXfwLK3GawGP/6/kCmq1cF4+KCTDUndcO67jYu6tf3JhGd98iYbv8aq
         71Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=DXdJtM2a59ym6M9TdEfmByz4F4Czr+WXnlJYPlHgUlo=;
        b=hXXA6bqdRIfHVMNOCMFoaU9noeKSFLc61XXyaPNYbaHAusZ6I6M0/rxakbX0ZNHCYN
         MqAIdY33PpMSA6cH8EL88ggnLTNv3a0Ay0Wum4nQyjjoLssba0cij5X9XeFoylO+kgpi
         VTGvCUWI9L6VTHJj2BsMQ/5qUs0OBUctnvjBF9gJScxnB8UFtBrjY06bv8jcC9JsFR/v
         c2GPsKGR8V9FY9jnLbxOV+KUaOxFx7J+8S0SwL70zdq5w9n15wLm9sny59nwoJTtFDVV
         1YvicRNNNx8MPCOlokpvjMtOIxZdQ+pVA0zmftyC0OYynwob90edE4tByxUeEZ9bHVaL
         DblA==
X-Gm-Message-State: AOAM53291L/tRi0z1Ip+cRFc+sIqqYSZr6TkdG65UOxhVfI7Szqh1y+I
        6bgdvZahke5rlilQNopfyW2mNHv/KndpjX6HxKs=
X-Google-Smtp-Source: ABdhPJwemEDEWUMgX95+lPtSstZMXKZY1WujMB1r5Qn15QWEYNIp1LuTE2gx2qxgE8EyLmOXNbZA3tyat+AR/4DwwuE=
X-Received: by 2002:a17:902:b20d:b0:163:f35c:312d with SMTP id
 t13-20020a170902b20d00b00163f35c312dmr5543333plr.92.1654185412927; Thu, 02
 Jun 2022 08:56:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:1d1:b0:161:f875:98b0 with HTTP; Thu, 2 Jun 2022
 08:56:52 -0700 (PDT)
Reply-To: thomaslucasloanoffer1@gmail.com
From:   Maryam Muhammad <maryammuhd931@gmail.com>
Date:   Thu, 2 Jun 2022 16:56:52 +0100
Message-ID: <CABBEDSbm5KA0+iTdAJWZ+VpaDHabJK=6J_MbJDbFOhLzY+4e5Q@mail.gmail.com>
Subject: Kreditangebot mit 2 % Zinssatz gelten
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hallo,

Ben=C3=B6tigen Sie einen Gesch=C3=A4ftskredit oder einen Privatkredit? Ich
m=C3=B6chte Sie wissen lassen, dass wir alle Arten von Darlehen zu einem
Zinssatz von 2 % anbieten. Kontaktieren Sie uns noch heute =C3=BCber diese
E-Mail: thomaslucasloanoffer1@gmail.com

Vollst=C3=A4ndiger Name:
Darlehensbetrag:
Leihdauer:
Telefonnummer:
Land:
Sex:

Kontaktieren Sie uns noch heute =C3=BCber diese E-Mail:
thomaslucasloanoffer1@gmail.com

Mit freundlichen Gr=C3=BC=C3=9Fen,
Herr Thomas Lukas.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F105919FE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbiHMLVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMLVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 07:21:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF386FD10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 04:21:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n4so3666754wrp.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=GyIdygXpERIYq0zhovmgdDSjsG4Trhk4Rphv5GwxReI=;
        b=nWP7d/4lKLUyWSF7JZg3WuTHaAv1Jy0wb359la2h49zrvWl7OpCZSw2XpJk/PNN50u
         JqCPl8gCH3BFK+OAdq7AsFbvYG89K+jWgJOOJ5WVuq5igzuJV9jzTY20iqQViXUiASsV
         GZHVkUBkoN0Hhf1pN+EJokHLDpwWsRw6nFy3JBEVL+sxkonZvgGoHJAFkVhuYfXFJRue
         U+O7UzA/hUinbvvasQ68Epy3GZxOP95EDt9hfXKWIhL5KIO+NR8l25+MabyLiPVlpB6r
         iGE/ZyW1iEu37JkMxmzBjUYfmSblJA39xMrUgHktM1WEbD7mQzdob16TKc3RBBwsN84I
         eoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GyIdygXpERIYq0zhovmgdDSjsG4Trhk4Rphv5GwxReI=;
        b=O3wEwJrwjK2K1g78tKshfZHBKsoaUVgjIw3PfLswGgO12/zGZm3J2lXMisPz6XLjaS
         iJa7Hqs6VvIFk7iSP3DQTMH8cZN5+rG8PEoVSh/a2CxlSwwoTO8QYAfhrwlCxtsdaBw6
         cyIvjcMxXQjkp33inviQpL+IKgm7Ci+5CRP4Zv8zSBIXCp+zdUDK5ZLrNV8C6KaKtDdA
         hwZrj7adXsVlr0LVpE6HWYmMmzp2Swg/e704CEV0pCIasqlSw+E1d2vtuqXdFqBbCw5S
         qO/Q23KGg6cgqC5+9prX5gardp2ZEB1GcU+648/WYZIiaHqOjifbQjW563+bfvnD3+my
         ot3Q==
X-Gm-Message-State: ACgBeo2Qh36Vblj3qy54/dVMFFtFMYsApHwjFutZW/PQO/V3cqRVVFLm
        vRv9/WjFpmpGDLKbDQTQ5JtkM9FzqwzeOwOstkM=
X-Google-Smtp-Source: AA6agR65/sCMHQyokFr641dZggUSa2uL1Yji5WKtNdOzOg6x9FFJPid3H/G0CN+cHWM1hJo0akdkrSZS4WZ1IvP7BDo=
X-Received: by 2002:a5d:5847:0:b0:220:9a9c:d819 with SMTP id
 i7-20020a5d5847000000b002209a9cd819mr4065655wrf.643.1660389711221; Sat, 13
 Aug 2022 04:21:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:df8a:0:0:0:0:0 with HTTP; Sat, 13 Aug 2022 04:21:50
 -0700 (PDT)
Reply-To: aseanvietnam55@gmail.com
From:   ASEAN VIETNAM <rw38128@gmail.com>
Date:   Sat, 13 Aug 2022 11:21:50 +0000
Message-ID: <CANBbbzEvgH2sbN1E7KrVrqXXVR_O+AkmKKqXjrA68K6=g6q4LA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:444 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4966]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rw38128[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rw38128[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [aseanvietnam55[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hello,

You have an important message get back to me for more information.

Mr. Le Luong Minh
(Ph=C3=B3 C=E1=BB=A5c Ng=C3=A2n kh=E1=BB=91) Deputy Department of the Treas=
ury
Vietnam.

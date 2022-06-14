Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F49754B055
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356906AbiFNMMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356852AbiFNMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:12:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF8110
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:12:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso5717099pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kuEgcMgVDUHYFfJyXF9gOzSC47A94xAWGdocmAZibCA=;
        b=RuMtVGEO+6tq5XGR0Rr499xwIMSRVbN/4cN4KZd4YPM/1QpluuuXV3jOtdQq2zxXo7
         Jse/fXH8FOKl7xs5s+9XKpcA2naAbTk7oxFqJVxuQhLZbgdc3u3KjbAwjkDfpoq0G4CQ
         ETPDObwR1LAvTp7EO/YsJ6f5YVTDP4xyFMYfY3aZoVxCP68P1NAMrXVFmvPq35dZY49X
         YjOAT9MwxnfZEBsgW7g2Hg2pTFtQSa9p9pE4qeL716R8rM1UR2KkOi0u6mxJhpm43v4M
         LWn1viTWqcHAsxCzKzx2oZ+gBhfcsiQy3tpAyZkGpL9EhghGwX8srMY2KZeN/IXbm+qx
         u7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=kuEgcMgVDUHYFfJyXF9gOzSC47A94xAWGdocmAZibCA=;
        b=KSIfoIkxEIKKznIN9bXGDd0N4RZIoszGjeTTGGKFtmKVuxRVMFhILF3cUMOSd6ycdS
         TmI5a2b6kZf7BDRw4tLdtP7W7uU86y5pqKSmNuCox11YOu8rp55+8FT0JGd1vid70Jc/
         4cLYkJ9K3pAWx57z9ogWlToqiOUpb6draHAwk5/Ulef5AvdFjgfflalpkVm4fh5FngIM
         HyZp9fZcG5V/tzOHgzC+X/Qi8XC4KKPf6rfWNPD37sBDH+ll5H4QW7hHCrCdN4q68G/g
         T6GPAEh5l700MSq5jDb7+rJ053rb0KFByAk6+gaBiC/WFZe8T5iVLHsBXl2oSZfwqQty
         RrkA==
X-Gm-Message-State: AJIora8PZlY5nApMor1RQnMm+08kUnh1NhzxJ66HrJ4WM7UiDO9z/DYj
        Ew4qn2Fwmg558Pf4pjBdSJ1iUfp4Hiz7FK5RJPc=
X-Google-Smtp-Source: AGRyM1uJVeDW2CZ+mUYdgTf8Mp5Gc0fRKbkOqqU20Xm20gGRaXt5epy/3vA+unbRVq2Y9MBclLZvDdBoORHiZ0oWzdY=
X-Received: by 2002:a17:903:234a:b0:167:997f:bc53 with SMTP id
 c10-20020a170903234a00b00167997fbc53mr4162675plh.47.1655208737989; Tue, 14
 Jun 2022 05:12:17 -0700 (PDT)
MIME-Version: 1.0
Sender: mwanczyk658@gmail.com
Received: by 2002:a17:90b:691:0:0:0:0 with HTTP; Tue, 14 Jun 2022 05:12:17
 -0700 (PDT)
From:   Frances Patrick <francespatrick49@gmail.com>
Date:   Tue, 14 Jun 2022 05:12:17 -0700
X-Google-Sender-Auth: qoxpF83BnQG_H-GLOYMfq7dJiig
Message-ID: <CAJ=HSnhfim+Pg_yOLTFyv=ZKAT+iA8hvhUaDYTh5reS6hetxVA@mail.gmail.com>
Subject: Donation to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Hello, Dearest Friend,

Two Million Euros has been donated to you by Frances and Patrick
Connolly, we are from County Armagh in Northern Ireland, We won the
New Year's Day EuroMillions draw of  =C2=A3115 million Euros Lottery
jackpot which was drawn on New Year=E2=80=99s Day. Email for more details:
francespatrick49@gmail.com Looking forward to hearing from you soon,

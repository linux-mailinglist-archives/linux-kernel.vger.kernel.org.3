Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196164B2710
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345878AbiBKN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:28:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbiBKN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:28:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ABD1DE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:28:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id s7so16544961edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ZxV+fDtUiooj7CgVSvQYercPIjoPkRCu2t/WG/Oga+A=;
        b=RcHGk3M9dm/jRH/HONRd+OPnYtxPLSYp9NwNr2aZtOamhIRAJCzhSLS7vJY2bFGwhT
         ore0W6N4wM1cBlIfomn118TPeW7LZBrDa8Ey02Ihz5lenG75dE0T/dNPf1tGwyYmoDT2
         oNjQuMzCnJmOJeOIAnCymGPeZ5+R7rWey6GabSIAM+NmVNWhbZprezA45/TBdGLodc4X
         iYKh0r1gmZrFOL3fDAIFGXSLD2DSs5viigjsxlACspVmfivfBdZoJS6jlnpiYjPB+H8k
         Oj6iW9CtMe5W7LGcPbkQqunWJ9UlZIQ/CXruebU0iTjfFyCkQKU12ZOiOoqeRsyYlcEi
         SN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ZxV+fDtUiooj7CgVSvQYercPIjoPkRCu2t/WG/Oga+A=;
        b=IXg/WkfvRm7sxGEtMInN8BkX0tre2m+bSmxJZYMWsKkBy7tBz4N4bH0iHnW53IhyuK
         CeNH4/VGSpTzmzWMy62xnEOM7TV9Wymj/4eGstXuR8HsPyX0QZY9UbQPlZ+/L31Un/q/
         erkbSBwqg3Q4FfoMLWaJrrjDLMEiCBngFZEeS2c6sJYImmmm9mfosGqDVrr4/Q4RT4l3
         0WLwSo1IuBnVnylzafjxVtug6cHUB0d6SqubBhouah1dS+NeRxaOf9HNLtHxeSEAkony
         tyZEmhRU/7I9V8KGdYZK7r9oJymOwO7EBVr0EOknbe59QPcowuP5W3W3eib7yVQnK63C
         Tuhw==
X-Gm-Message-State: AOAM530uENsU4PKOBdHQClQU46L1k11fa+bkSDSmPYfQzg6KwpZEScGB
        6OTghwom6QuMmLJ+yguoVuLu+49SVSfmQKtMnDI=
X-Google-Smtp-Source: ABdhPJyYdmBZRgaCrfMPgLnh0+4XPUK+jzFlp33qOZVSzYNfIZiEMJ6QrmNgVXbYUm0zPvV9USMhaEy0DfxWO31/k9Q=
X-Received: by 2002:a05:6402:23a7:: with SMTP id j39mr1871646eda.317.1644586091374;
 Fri, 11 Feb 2022 05:28:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a50:cae:0:0:0:0:0 with HTTP; Fri, 11 Feb 2022 05:28:10 -0800 (PST)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <frankalain02@gmail.com>
Date:   Fri, 11 Feb 2022 14:28:10 +0100
Message-ID: <CAHP2ksiwLcFRw22d5NuwnwgQdS25rvL5D9+eO9+u3x4GZDmbhQ@mail.gmail.com>
Subject: Rowland
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I called to know if you received my previous email, reply to me
asap.
Rowland

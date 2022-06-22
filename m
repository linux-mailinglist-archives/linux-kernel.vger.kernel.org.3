Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A055546FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiFVK1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiFVK07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:26:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37683A5D5;
        Wed, 22 Jun 2022 03:26:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eq6so15895608edb.6;
        Wed, 22 Jun 2022 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=37rSlhRpHHWymSWDtV1LKUaah1wVrGYKsjIbHejy7lI=;
        b=HSqzpI56Wd/maCsUqAm6GW+vL3gDlxXpbeI5QmlV2sj6irWKRsz51o7VAbYl1Wpn7u
         9Qvs50rqTlPfin6a86lUOvc2lOY1nAAwv0y+4iOmYDOd0x5QutPpPYamxVm6TgPELYmi
         gzCgiliyXbrOuvFzQa4gIqPdvnpa8kEENRl1NiSetyJHJ7s5F81a4xyM1HKRhbhxAyJf
         VniU9LZPctrAhCMMfajUERbfulXQabhYVLoue398el8ZQgWqWiiGg560nHtTFI4rtuvQ
         zAIy5xLcytDz1ZutL5bs3KTPb5FK91rPHo6D2lBA0kgj5CEwk59d7KwiaVNiW2o2eyy2
         r6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=37rSlhRpHHWymSWDtV1LKUaah1wVrGYKsjIbHejy7lI=;
        b=GJHss/V5Ioy93Ju5vgyYr0k8xpq5mYQMzU7GXQaSbCabUjxecNzH1bjesBlOqnKWuf
         JOe1GzeEERMUQZzDuAYOUmiHpRt6YNRUEWhmEPm6mNPatPOW8uiOH+UE20jOBFJpHwFQ
         y8gh2sMoudcjU+DkTWP511tcyCZsZovSIUmI35wogXLo3rEQDHTPYwPiSTuGzqTG1RNh
         QjE5xHmTYtOQiRbsP0nZ+p/pman9CikvOfB+/fURMqqOoVUadPR2RiLlF76w0ZuB8IQh
         zxUZqhLxA6Ny0eJapklJYcvSDTlK2IYP7omQEJ97FBgZHw8vG1P1SFmZFkhijFl3yE8E
         yv9Q==
X-Gm-Message-State: AJIora/aJrHIGdsiTx7BOg9gaEHMlqx3Vo4MfyuVeNlO3uP2waHK+Peg
        A9Z2nSYtJ//IZ5x/1rYI9RPEwYzY2BSuTTVfQeY=
X-Google-Smtp-Source: AGRyM1v4azWWigiOn++l1Dtbx1fdOaa+R6QIGQ/aTOrCshjNUsBD3TDZWJE10f1vEBfdq0j3iu2c+b/URbfaYfSI9+k=
X-Received: by 2002:a05:6402:f8d:b0:435:6df2:68a with SMTP id
 eh13-20020a0564020f8d00b004356df2068amr3330060edb.209.1655893616422; Wed, 22
 Jun 2022 03:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220622094233.3681843-1-clg@kaod.org> <20220622094233.3681843-2-clg@kaod.org>
In-Reply-To: <20220622094233.3681843-2-clg@kaod.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jun 2022 12:26:19 +0200
Message-ID: <CAHp75VdBO1yPVH6NCEj8ZSYF2-6q0soE=8qNGrh7G=t7adRBZw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: aspeed: Add pr_debug in aspeed_spi_dirmap_create()
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:46 AM C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>
> It helps to analyze the default setting of the control register.

Replace "It" with a slightly more descriptive "what is it?".

Also make the subject aligned with the contents of the patch.

--=20
With Best Regards,
Andy Shevchenko

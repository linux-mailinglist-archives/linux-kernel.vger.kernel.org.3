Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559D357B48F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiGTKbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiGTKbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:31:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F1B43E6D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:30:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g1so23146137edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fmWdbBNeVd6AznfhSRe7U2H2UYlseHAMQsLeey/KFRE=;
        b=L6TLIAT0MaWBbwh2UxsCVEE18fLE5G564qtQy4wKQ2gOoHxoh/Ku9OOybEVWtkMPSw
         7EZ2bCkqgSwu2NlMVP16b0CcabDq5Biu76qj2CCEDFBnTdy6DPs64TThAbQDOANA+qt8
         2w7QAG42MHuzewGY1hn2A2rBjVlVV1dnqwG34KaBbYg9jO1VEJfUbs9Z3jhJXO+HA9XB
         U3cFY8+Z7dbCN3Cov39IjFuogNqFWxwBRittYT5oqJdSpqLH6+Ge7dADrBaxC26avGsh
         VjwnIxma4Lrsx6XHDHg5PreuF7Vdhd+Xqdxcki4rK9F7ATbM6tD5tY3KBHKkl/34tAyD
         cQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=fmWdbBNeVd6AznfhSRe7U2H2UYlseHAMQsLeey/KFRE=;
        b=XVPSSpp60+y91EJHykNMAoCTLPFbLztWJ7kklaeNL5uSD4+GiNghE68Euw2nbN17sR
         GbecqgKNLqd5qqR7vQWvm8QVU9r6y3oi2VxLcnGMymMOeEKZ8yDuCfDNdr+gLitOt9bE
         TGOJvP6A/Te4o0w5OZT5S6slQphldh5ph8/an6tojBc8lER+3k+Wx6XHX0oK8W0WHNzH
         6GJazBmhRh22UzxgmzRaOBtnKndTy46lmTnKydpRCHVMjiJSOIA0YKxpxkVFKL+kYSBP
         P3sjyCiDVPmDZ1WzVPuW0WHTj9uEu26KraCPhteFp6NblR+h98WdEH/UfOUjWK5pNoyK
         nOog==
X-Gm-Message-State: AJIora+BrEQEdNTDTTeHdCYHhPLisJYT0uZR8SlsDgKOzTs7NIO9aHil
        TjMUborij573DRiZvk2uz60l2ghK5A/TgRhQpvQ=
X-Google-Smtp-Source: AGRyM1vk/40rjDzWH83Qxb/bLUmHEL6by0O4SaxJ3eAKB1VswKiY5rokfwM1XAj4Jhc0oEg2GY+wyqWiVawiVnkGWQE=
X-Received: by 2002:a05:6402:2553:b0:43a:caa2:4956 with SMTP id
 l19-20020a056402255300b0043acaa24956mr48829825edb.406.1658313057532; Wed, 20
 Jul 2022 03:30:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:640c:1b87:b0:179:693:70d with HTTP; Wed, 20 Jul 2022
 03:30:56 -0700 (PDT)
Reply-To: jon768266@gmail.com
From:   johnson <rahamaaliou74@gmail.com>
Date:   Wed, 20 Jul 2022 10:30:56 +0000
Message-ID: <CAHhQV0cQUaPs8ad8cJ0paAixJznQam93JSHUcxvRV5hTENdMzw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4924]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rahamaaliou74[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rahamaaliou74[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jon768266[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0KHRgNC10ZzQtdC9INGB0YPQvCDRiNGC0L4g0LzQvtC20LDQvCDQtNCwINCy0LUg0LjQvdGE0L7R
gNC80LjRgNCw0Lwg0LfQsCDQvNC+0ZjQvtGCINGD0YHQv9C10YUg0LLQviDQv9GA0LXRhNGA0LvQ
sNGa0LXRgtC+INC90LANCtGC0LjQtSDRgdGA0LXQtNGB0YLQstCwINGB0L4g0L/QvtC80L7RiCDQ
vdCwINC90L7QsiDQv9Cw0YDRgtC90LXRgCDQvtC0INCY0L3QtNC40ZjQsC4g0JLQviDQvNC+0LzQ
tdC90YLQvtCyINGB0YPQvCDQstC+DQrQmNC90LTQuNGY0LAg0LfQsCDQuNC90LLQtdGB0YLQuNGG
0LjRgdC60Lgg0L/RgNC+0LXQutGC0Lgg0YHQviDQvNC+0Zgg0YPQtNC10Lsg0L7QtCDQstC60YPQ
v9C90LDRgtCwINGB0YPQvNCwLiDQktC+DQrQvNC10ZPRg9Cy0YDQtdC80LUsINC90LUg0LPQuCDQ
t9Cw0LHQvtGA0LDQstC40LIg0LLQsNGI0LjRgtC1INC80LjQvdCw0YLQuCDQvdCw0L/QvtGA0Lgg
0Lgg0L7QsdC40LTQuCDQtNCwINC80LgNCtC/0L7QvNC+0LPQvdC10YLQtSDQstC+INGC0YDQsNC9
0YHRhNC10YDQvtGCINC90LAg0YLQuNC1INGB0YDQtdC00YHRgtCy0LAg0Lgg0L/QvtC60YDQsNGY
INGC0L7QsCDRiNGC0L4g0YLQvtCwINCx0LXRiNC1DQrQvdC10YPRgdC/0LXRiNC10L0g0L7QsdC4
0LQuINCh0LXQs9CwINC60L7QvdGC0LDQutGC0LjRgNCw0ZjRgtC1INGB0L4g0LzQvtGY0L7RgiDR
gdC10LrRgNC10YLQsNGAINCy0L4g0JvQvtC80LUsINCi0L7Qs9C+INGB0L4NCtC90LXQs9C+0LLQ
uNC+0YIg0L/QvtC00L7Qu9GDINC60L7QvdGC0LDQutGCLCDQvNC4INC/0LDQtNC90LAg0LfQsNCy
0LXRgNC10L3QsCDQstC40LfQsCDQutCw0YDRgtC40YfQutCwINC30LAg0LHQsNC90LrQvtC80LDR
giwNCtC30LDQvNC+0LvQtdGC0LUg0LPQviDQtNCwINCy0Lgg0ZjQsCDQuNGB0L/RgNCw0YLQuCDQ
stC40LfQsNGC0LAg0LfQsCDQsdCw0L3QutC+0LzQsNGCINC+0LQgMjUwLjAwMCwwMCDQo9Ch0JQg
0YjRgtC+DQrRmNCwINC+0YHRgtCw0LLQuNCyINC60LDRmCDQvdC10LPQviDQt9CwINCy0LDRiNCw
INC60L7QvNC/0LXQvdC30LDRhtC40ZjQsCDQt9CwINGB0LjRgtC1INC80LjQvdCw0YLQuCDQvdCw
0L/QvtGA0Lgg0LTQsA0K0L/QvtC80L7Qs9C90LDQvCAsDQoNCtCX0LDRgtC+0LAg0L/QvtC/0L7Q
u9C90LXRgtC1INCx0LXRgdC/0LvQsNGC0L3QviDQuCDRgdGC0LDQv9C10YLQtSDQstC+INC60L7Q
vdGC0LDQutGCINGB0L4g0LzQvtGY0LDRgtCwINGB0LXQutGA0LXRgtCw0YDQutCwINC4DQrQv9C+
0YPRh9C10YLQtSDQs9C+INC60LDQtNC1INC00LAg0LLQuCDRmNCwINC40YHQv9GA0LDRgtC4INCy
0LjQt9Cw0YLQsCDQt9CwINCx0LDQvdC60L7QvNCw0YIg0YjRgtC+INGY0LAg0YHQvtC00YDQttC4
DQrRgdGD0LzQsNGC0LAuINCS0LUg0LzQvtC70LDQvCwg0LLQtdC00L3QsNGIINC40LfQstC10YHR
gtC10YLQtSDQvNC1INCw0LrQviDQs9C+INC00L7QsdC40LXRgtC1INC30LAg0LTQsCDQvNC+0LbQ
tdC80LUNCtC30LDQtdC00L3QviDQtNCwINGY0LAg0YHQv9C+0LTQtdC70LjQvNC1INGA0LDQtNC+
0YHRgtCwINC/0L4g0YHQuNGC0LUg0YHRgtGA0LDQtNCw0ZrQsCDQstC+INGC0L7QsCDQstGA0LXQ
vNC1LiDQstC+DQrQvNC+0LzQtdC90YLQvtCyLCDRmNCw0YEg0YHRg9C8INC80L3QvtCz0YMg0LfQ
sNGE0LDRgtC10L0g0L7QstC00LUg0L/QvtGA0LDQtNC4INC40L3QstC10YHRgtC40YbQuNGB0LrQ
uNGC0LUg0L/RgNC+0LXQutGC0Lgg0YjRgtC+DQrQs9C4INC40LzQsNC8INGB0L4g0LzQvtGY0L7R
giDQuNC90LTQuNGB0LrQuCDQv9Cw0YDRgtC90LXRgCwg0LrQvtC90LXRh9C90L4g0LfQsNC/0L7Q
vNC90LXRgtC1INC00LXQutCwINC90LAg0LzQvtGY0LDRgtCwDQrRgdC10LrRgNC10YLQsNGA0LrQ
sCDQvdCwINCy0LDRiNC10YLQviDQuNC80LUg0Lgg0L/RgNC10L/RgNCw0YLQuNCyINC40L3RgdGC
0YDRg9C60YbQuNGY0LAg0LTQsCDQstC4INGY0LAg0L7RgtC/0YPRiNGC0LgNCtCy0LjQt9C90LDR
gtCwINC60LDRgNGC0LjRh9C60LAg0L3QsCDQsdCw0L3QutC+0LzQsNGCINC30LAg0LLQsNGBINC4
INCy0LjQtSDRgdCw0LzQuCwg0LfQsNGC0L7QsCDRgdC70L7QsdC+0LTQvdC+INC00LANCtGB0YLQ
sNC/0LjRgtC1INCy0L4g0LrQvtC90YLQsNC60YIg0YHQviDQvdC10LPQviDQuCDQtNCwINC80YMg
0LPQuCDQv9GA0L7RgdC70LXQtNC40YLQtSDQstCw0YjQuNGC0LUg0LjQvdGE0L7RgNC80LDRhtC4
0LgsDQrQstCw0YjQuNGC0LUg0L/QvtC70L3QuCDQuNC80LjRmtCwLCDQsNC00YDQtdGB0LAg0Lgg
0LHRgNC+0Zgg0LfQsCDQutC+0L3RgtCw0LrRgiDQt9CwINC70LXRgdC90LAg0LrQvtC80YPQvdC4
0LrQsNGG0LjRmNCwDQrQtNC+0LTQtdC60LAg0L3QtSDRmNCwINC00L7QsdC40LXRgtC1INCy0LjQ
t9Cw0YLQsCDQutCw0YDRgtC40YfQutCwINC30LAg0LHQsNC90LrQvtC80LDRgi4NCihqb243Njgy
NjZAZ21haWwuY29tKQ0KDQrQodC+INC/0L7Rh9C40YINCtCe0YDQu9Cw0L3QtNC+INCc0L7RgNC4
0YEuDQo=

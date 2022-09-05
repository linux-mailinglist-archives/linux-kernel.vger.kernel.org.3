Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF15ACFFF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiIEKX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiIEKXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:23:06 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766C0B4B5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:23:05 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id g185so3916335vkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=gDOAAIbklvT29CJuu7pOpzOXc61p69Nt20uj65HH+Lg=;
        b=MOkrXfAJNGqIpa9k8LbDYP0VjFBVuipcgQXrhbGa7k7twMvW0v22mFJYYY1CKAAu8t
         J8nV06+D7tmCDU7NHWtaUCAwv8DSQRo6+R0cD8pi3ogTO2cbcUhxqqI4xPoXkjB/SBFz
         ulbLXwMhgxVuhxNMWvbjxSRk/R1eKztqhnVgiIeiuaeNyGA9lmceqwfapCmWZjcog033
         6HnuWKR2wTWC0Y48L4U0b6UrfH7IvtgyJ4ND+RKscpAE+4lIS4o6j3paNuQnEgC3Dju+
         JGiqBL9KcuTeR3hFLwtCBVyEHnAYYgsASVBiNW3iD8UXyti3ZOt29uWBqE1aSa2qYei9
         ZLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gDOAAIbklvT29CJuu7pOpzOXc61p69Nt20uj65HH+Lg=;
        b=xqrFMza9Bx2sSPK1Hk6ZN0z1W8nOGsP6FXPPT4cTLgRPeQe/uZ0/TuceY9fUDT/T8B
         OtThGQMqA20QtOvYDvmbUZ2rvdrIzvQ4k3lrEg/vO/SMRLigMcW5UrTMcfiJhS/IhiKl
         fygnwVwl3vByXVVJWNilBd1ObiJFivumLbjjwMlpYi0gVNn1A8Hn9/km+wvkHek5V42Q
         PD4N6uZ+2gtLHi7eol6X44Mah8x4VSJ2NAtDrzSradG/P2avQdqAZBN8qCYJsVGgcybk
         uvueK+Wiatjp2JoTU7jsPzc52u7bELdrYz2f2fv0QDxc63ci3f8oAdZOXgYiVtVD8x6X
         3p1A==
X-Gm-Message-State: ACgBeo1+AD/a67wzCIGTobb0IXTBnOkU3sN/Wa74aBqV2JX0HIhq5tEl
        TOqS2mwPtA0XQSvf/NJbXr7jrKFS0PphQZ4bVK0=
X-Google-Smtp-Source: AA6agR4nASQXgiNrfnyKM3qda065KyN5E9LiO1GUAzDjPmNNsWMfA4sxI1IlbtNSV1ihgoQjtWdLxajcO81ZzKarpyg=
X-Received: by 2002:a1f:b446:0:b0:394:e8c2:ca45 with SMTP id
 d67-20020a1fb446000000b00394e8c2ca45mr6055282vkf.12.1662373384295; Mon, 05
 Sep 2022 03:23:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6122:90f:0:0:0:0 with HTTP; Mon, 5 Sep 2022 03:23:03
 -0700 (PDT)
Reply-To: philipsjohnsongood@gmail.com
From:   philips <okeyyoyopa7@gmail.com>
Date:   Mon, 5 Sep 2022 11:23:03 +0100
Message-ID: <CAH8nkvYbk4sCSXJ9a4c3q0GQvqSXtK-TSfrkdX+p_RWs6AqvcA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [okeyyoyopa7[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [okeyyoyopa7[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 UPPERCASE_50_75 message body is 50-75% uppercase
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0J/QntCS0JXQoNCV0J3QndCr0Jkg0Jgg0J3QntCi0JDQoNCY0KPQoQ0KINCb0J7QndCU0J7QnS3Q
ktC10LvQuNC60L7QsdGA0LjRgtCw0L3QuNGPDQoNCtCx0YPQtNGD0YnQtdCz0L46INC00L7RgNC+
0LPQvtC5INC00YDRg9CzDQoNCtCf0L7QttCw0LvRg9C50YHRgtCwLCDQvdC1INC+0LHQuNC20LDQ
udGC0LXRgdGMLCDQtdGB0LvQuCDRjdGC0L4g0YHQvtC+0LHRidC10L3QuNC1INC/0YDQuNC00LXR
giDQuiDQstCw0LwsINC/0L7RgdC60L7Qu9GM0LrRgw0K0Y8g0LTQvtC70LbQtdC9INCx0YvQuyDQ
v9C+0LvRg9GH0LjRgtGMINCy0LDRiNC1INGB0L7Qs9C70LDRgdC40LUg0Lgg0L7QtNC+0LHRgNC1
0L3QuNC1LCDQv9GA0LXQttC00LUg0YfQtdC8INC+0YLQv9GA0LDQstC40YLRjA0K0Y3RgtC+INC/
0YDQtdC00LvQvtC20LXQvdC40LUg0L/QviDRjdC70LXQutGC0YDQvtC90L3QvtC5INC/0L7Rh9GC
0LUuINCvINC00LXQudGB0YLQstC+0LLQsNC7INGC0LDQuiwg0LrQsNC6INGPINGB0LTQtdC70LDQ
uywNCtC40Lct0LfQsCDQstCw0LbQvdC+0YHRgtC4INC4INGB0YDQvtGH0L3QvtGB0YLQuCDRjdGC
0L7Qs9C+INC00LXQu9CwLiDQoSDQutCw0LrQvtC5INCx0Ysg0YHRgtC+0YDQvtC90Ysg0LLRiyDQ
vdC4DQrRgdC80L7RgtGA0LXQu9C4INC90LAg0Y3RgtC+LCDQv9GD0YHRgtGMINCy0LDQvCDQsdGD
0LTQtdGCINC/0YDQuNGP0YLQvdC+INCx0YvRgdGC0YDQviDQvtGC0LLQtdGC0LjRgtGMINC70LjQ
sdC+DQrQvtGC0YDQuNGG0LDRgtC10LvRjNC90L4sINC70LjQsdC+INC/0L7Qu9C+0LbQuNGC0LXQ
u9GM0L3Qvi4NCg0K0JzQtdC90Y8g0LfQvtCy0YPRgiDQpNC40LvQuNC/0YEg0JTQttC+0L3RgdC+
0L0uINCvINC+0YLQv9GA0LDQstC40Lsg0LLQsNC8INC80L7QtSDRjdC70LXQutGC0YDQvtC90L3Q
vtC1INC/0LjRgdGM0LzQviDRgNCw0L3QtdC1DQrQsdC10Lcg0L7RgtCy0LXRgtCwLCDQsiDQvNC+
0LXQvCDQv9C10YDQstC+0Lwg0Y3Qu9C10LrRgtGA0L7QvdC90L7QvCDQv9C40YHRjNC80LUg0Y8g
0YPQv9C+0LzRj9C90YPQuyDQviDQutC70LjQtdC90YLQtSwNCtC60L7RgtC+0YDRi9C5INGD0LzQ
tdGAIDE1INGB0LXQvdGC0Y/QsdGA0Y8gMjAxNSDQs9C+0LTQsC4g0K8g0YHQtNC10LvQsNC7INC9
0LXRgdC60L7Qu9GM0LrQviDQv9C+0YHRgtGD0L/Qu9C10L3QuNGPLA0K0YfRgtC+0LHRiyDQvdCw
0LnRgtC4INC60L7Qs9C+LdC70LjQsdC+INC40Lcg0LTQsNC70YzQvdC40YUg0YDQvtC00YHRgtCy
0LXQvdC90LjQutC+0LIg0LzQvtC10LPQviDQutC70LjQtdC90YLQsCwg0L3QviDRjdGC0L4NCtCy
0LXRgNC+0Y/RgtC90L4g0LHQtdC30YPRgdC/0LXRiNC90L4sINGPINGC0YDQtdCx0YPRjiDQstCw
0YjQtdCz0L4g0L/QtdGA0LLQvtCz0L4g0L/RgNC10LTRgdGC0LDQstC70LXQvdC40Y8g0LrQsNC6
DQrQsdC70LjQt9C60L7Qs9C+INGA0L7QtNGB0YLQstC10L3QvdC40LrQsCDQkdCb0JjQltCd0JXQ
k9CeINCg0J7QlNCh0KLQktCV0J3QndCY0JrQkCDQnNCe0JXQk9CeINCf0J7QodCb0JXQlNCd0JXQ
k9CeINCa0JvQmNCV0J3QotCQLA0K0J/QntCi0J7QnNCjINCn0KLQniDQoyDQktCQ0KEg0J7QlNCY
0J3QkNCa0J7QktCr0JUg0JjQnNCV0J3QkCDRgSDQv9C+0LrQvtC50L3Ri9C8LCDRg9C90LDRgdC7
0LXQtNC+0LLQsNGC0Ywg0LTQtdC/0L7Qt9C40YLQvdGL0LkNCtC00LXQv9C+0LfQuNGCINC90LAg
0YHRg9C80LzRgyAyIDcwMCAwMDAsMDAg0YTRg9C90YLQvtCyINGB0YLQtdGA0LvQuNC90LPQvtCy
ICjRgtC+0LvRjNC60L4g0LTQstCwINC80LjQu9C70LjQvtC90LANCtGB0LXQvNC40YHQvtGCINGC
0YvRgdGP0Ycg0LHRgNC40YLQsNC90YHQutC40YUg0YTRg9C90YLQvtCyINGB0YLQtdGA0LvQuNC9
0LPQvtCyLCDQsiBGU1QtQkFOSyBMb25kb24sDQrQvtGB0YLQsNCy0LvQtdC90L3Ri9C5INC60LvQ
uNC10L3RgiDQtNC+INGC0L7Qs9C+LCDQutCw0Log0L7QvSDQsdGD0LTQtdGCINC60L7QvdGE0LjR
gdC60L7QstCw0L0sDQoNCtCR0LDQvdC6INCy0YvQtNCw0Lsg0LzQvdC1LiDQryDQvdCw0LTQtdGP
0LvRgdGPLCDRh9GC0L4g0LLRiyDQvdC1INGA0LDQt9C+0LHQu9Cw0YfQuNGC0LUg0Lgg0L3QtSDQ
v9GA0LXQtNCw0LTQuNGC0LUg0Y3RgtC+DQrQtNC+0LLQtdGA0LjQtSDQuCDRg9Cy0LXRgNC10L3Q
vdC+0YHRgtGMLCDQutC+0YLQvtGA0YvQtSDRjyDQv9GL0YLQsNGO0YHRjCDRg9GB0YLQsNC90L7Q
stC40YLRjCDRgSDQstCw0LzQuCDQtNC70Y8g0L3QsNGI0LXQuQ0K0LLQt9Cw0LjQvNC90L7QuSDQ
stGL0LPQvtC00YssINGPINC90LUg0YXQvtGH0YMsINGH0YLQvtCx0Ysg0YEg0L3QsNC80Lgg0LHR
i9C70LAg0YLRgNC10YLRjNGPINGB0YLQvtGA0L7QvdCwLCDRjdGC0L4NCtC00L7Qu9C20L3QviDQ
sdGL0YLRjCDRgdC10LrRgNC10YLQvtC8INC80LXQttC00YMg0LzQvdC+0Lkg0Lgg0LLQsNC80Lgu
INCvINC30LDQstC10YDRj9GOINC4INCz0LDRgNCw0L3RgtC40YDRg9GOLCDRh9GC0L4NCtGN0YLQ
viDQsdGD0LTQtdGCINCy0YvQv9C+0LvQvdC10L3QviDQsiDRgdC+0L7RgtCy0LXRgtGB0YLQstC4
0Lgg0YEg0LfQsNC60L7QvdC90YvQvCDRgdC+0LPQu9Cw0YjQtdC90LjQtdC8LCDQutC+0YLQvtGA
0L7QtQ0K0LfQsNGJ0LjRidCw0LXRgiDQstCw0YEg0L7RgiDQu9GO0LHRi9GFINC90LDRgNGD0YjQ
tdC90LjQuSDQt9Cw0LrQvtC90L7Qsi4g0JLRgdC1LCDRh9GC0L4g0Y8g0YLRgNC10LHRg9GOINC+
0YIg0LLQsNGBLCAtDQrRjdGC0L4g0LLQsNGI0LUg0YfQtdGB0YLQvdC+0LUg0YHQvtGC0YDRg9C0
0L3QuNGH0LXRgdGC0LLQviwg0YfRgtC+0LHRiyDQvNGLINC80L7Qs9C70Lgg0L/RgNC+0LLQtdGB
0YLQuCDRjdGC0YMNCtGC0YDQsNC90LfQsNC60YbQuNGOLg0KDQrQlNC70Y8g0L/QvtC70YPRh9C1
0L3QuNGPINCx0L7Qu9C10LUg0L/QvtC00YDQvtCx0L3QvtC5INC40L3RhNC+0YDQvNCw0YbQuNC4
LCDQv9C+0LbQsNC70YPQudGB0YLQsCwg0YHQstGP0LbQuNGC0LXRgdGMINGB0L4NCtC80L3QvtC5
LCDQvtC20LjQtNCw0Y8g0LLQsNGI0LXQs9C+INGB0YDQvtGH0L3QvtCz0L4g0L7RgtCy0LXRgtCw
Lg0KDQrQl9Cw0YDQsNC90LXQtSDRgdC/0LDRgdC40LHQviDQuCDRhdGA0LDQvdC4INCy0LDRgSDQ
kdC+0LMsDQoNCtCc0LjRgdGC0LXRgCDQpNC40LvQuNC/0YEg0JTQttC+0L3RgdC+0L0sINGN0YHQ
utCy0LDQudGALg0K0KPRgdCw0LTRjNCx0LAgMiwg0J3RjNGOLdCu0L3QuNC+0L0t0YHRgtGA0LjR
giwgTEQxIDJQRg0K0JvQntCd0JTQntCdLdCS0LXQu9C40LrQvtCx0YDQuNGC0LDQvdC40Y8NCtCf
0J7QktCV0KDQldCd0J3Qq9CZINCYINCd0J7QotCQ0KDQmNCj0KENCiDQm9Ce0J3QlNCe0J0t0JLQ
tdC70LjQutC+0LHRgNC40YLQsNC90LjRjw0KUE9WRVJFTk5ZWSBJIE5PVEFSSVVTDQogTE9ORE9O
LVZlbGlrb2JyaXRhbml5YQ0K

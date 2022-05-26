Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E215350FC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiEZOsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346511AbiEZOsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:48:04 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807205839C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:48:02 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id u21so1259924vsk.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3M1pJkrNV2nAQ7sLw6tNTxeHC+mpzUh3rS9LQ55Zcec=;
        b=O59j5b49OpZTjctrAIiVjpIeOM1E909gOmgAjVx4Q5Hz048uhvg/svaxBb7n2UKIC8
         prQICrLpeiMyykqcDfDeOA+Npcwf4X8wWlRvScxUNAtZdu9hP7fQdKZudSbWN8h/dFzf
         rrY/lJtwrDL4t/HRhp1rhq/ZhbvzyG8Va5I1LVdmnvLCndW9fcP8CYAaPw6BX4Rwwr9T
         sp15skIp00KpKj3i7IBFVLCzqPKvpPGQzwIKnR4r7dJfNHsC6clTjNw4PYFybkzxtXeQ
         84W3vlBgYr9y9L77OyvSRkVEMsBKj0wO2McsynYPBN+P8XDjNOkVjUyi+r1Ynnv7EIrn
         WZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=3M1pJkrNV2nAQ7sLw6tNTxeHC+mpzUh3rS9LQ55Zcec=;
        b=h0iJd/1eG2Xx+dJkjP5VfUTjPuk9Nx16xaLixl3MjQP//VtARFCmJ5U4+3Q8WihSJr
         wq3w32S37JW8FVnUG7c+XCUcSA5NCwP3Q4O9js9Pqrh3nehTvHIFArrtSeh7QK9iN5t1
         H/+PRwOLs+9T/JVpe3K47g5l55i30oEfEwrNQJ1YaTf3WrJaH5P2iFeiZMLiP83v5EgO
         X9uNkS8boUTN0bQGAvrnSpn0uZlCRd3v3TiE6Rp4SQ4yuNsdtXVGhm3N7kgoLNfrZ3mr
         yUd783UQ7RNOC6CvvVnPoOS5yFlee0ti7LRQotke2ZITUU9pTD+EdVMdXrP6RLa6ds+B
         I8Rw==
X-Gm-Message-State: AOAM530yqkSl6ryplsN+z8oTCahCc05f2pteceZsFpI+MkAniDuh4qj8
        Xy2xuFFZHTOjJ/2U4hRqFE4LN6/gB7BivBQLIAI=
X-Google-Smtp-Source: ABdhPJy0Hz3Sj8JRfFw1Yn5IvC2lbaNAGH7JVJN49mODIkt9aqbwoRx9bSxHAmcygIFIL92J7I149Pz8opZXH+h2oTk=
X-Received: by 2002:a05:6102:e94:b0:337:9faa:4a5d with SMTP id
 l20-20020a0561020e9400b003379faa4a5dmr10019366vst.43.1653576481419; Thu, 26
 May 2022 07:48:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:3150:0:0:0:0:0 with HTTP; Thu, 26 May 2022 07:48:00
 -0700 (PDT)
Reply-To: uchennailobitenone@gmail.com
From:   uchenna <okeyyoyopa7@gmail.com>
Date:   Thu, 26 May 2022 14:48:00 +0000
Message-ID: <CAH8nkvY-d8i5bNsUZcnPHF9bTbx0Q3STPmLLKTU-3_jw0dwYeg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4988]
        *  1.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [okeyyoyopa7[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [okeyyoyopa7[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JLQvdC40LzQsNC90LjQtSDQn9C+0LbQsNC70YPQudGB0YLQsCwNCg0K0K8g0JHQsNGALiB1Y2hl
bm5hIGlsb2JpICwg0JrQsNC6INC00LXQu9CwLCDQvdCw0LTQtdGO0YHRjCDRgtGLINCyINC/0L7R
gNGP0LTQutC1INC4INC30LTQvtGA0L7Qsj8NCtCd0LDRgdGC0L7Rj9GJ0LjQvCDRgdC+0L7QsdGJ
0LDRjiDQstCw0LwsINGH0YLQviDRjyDRg9GB0L/QtdGI0L3QviDQt9Cw0LLQtdGA0YjQuNC7INGC
0YDQsNC90LfQsNC60YbQuNGOINGBINC/0L7QvNC+0YnRjNGODQrQvdC+0LLQvtCz0L4g0L/QsNGA
0YLQvdC10YDQsCDQuNC3INCS0LXQvdC10YHRg9GN0LvRiywg0Lgg0YLQtdC/0LXRgNGMINGB0YDQ
tdC00YHRgtCy0LAg0LHRi9C70Lgg0L/QtdGA0LXQstC10LTQtdC90Ysg0LINCtCS0LXQvdC10YHR
g9GN0LvRgyDQvdCwINCx0LDQvdC60L7QstGB0LrQuNC5INGB0YfQtdGCINC90L7QstC+0LPQviDQ
v9Cw0YDRgtC90LXRgNCwLg0KDQrQnNC10LbQtNGDINGC0LXQvCwg0Y8g0YDQtdGI0LjQuyDQstGL
0L/Qu9Cw0YLQuNGC0Ywg0LLQsNC8INC60L7QvNC/0LXQvdGB0LDRhtC40Y4g0LIg0YDQsNC30LzQ
tdGA0LUgMzUwIDAwMA0K0LTQvtC70LvQsNGA0L7QsiDQodCo0JAgKNGC0YDQuNGB0YLQsCDQv9GP
0YLRjNC00LXRgdGP0YIg0YLRi9GB0Y/RhyDQtNC+0LvQu9Cw0YDQvtCyINCh0KjQkCkg0LfQsCDQ
stCw0YjQuCDQv9GA0L7RiNC70YvQtQ0K0YPRgdC40LvQuNGPLCDRhdC+0YLRjyDQstGLINC80LXQ
vdGPINGA0LDQt9C+0YfQsNGA0L7QstCw0LvQuC4g0J3Qviwg0YLQtdC8INC90LUg0LzQtdC90LXQ
tSwg0Y8g0L7Rh9C10L3RjCDRgNCw0LQNCtGD0YHQv9C10YjQvdC+0LzRgyDQt9Cw0LLQtdGA0YjQ
tdC90LjRjiDRgdC00LXQu9C60Lgg0LHQtdC3INC60LDQutC40YUt0LvQuNCx0L4g0L/RgNC+0LHQ
u9C10LwsINC4INC40LzQtdC90L3QviDQv9C+0Y3RgtC+0LzRgyDRjw0K0YDQtdGI0LjQuyDQstGL
0L/Qu9Cw0YLQuNGC0Ywg0LLQsNC8INC60L7QvNC/0LXQvdGB0LDRhtC40Y4g0LIg0YDQsNC30LzQ
tdGA0LUgMzUwIDAwMCDQtNC+0LvQu9Cw0YDQvtCyINCh0KjQkCwg0YfRgtC+0LHRiw0K0LLRiyDR
gNCw0LfQtNC10LvQuNC70Lgg0YHQviDQvNC90L7QuSDRgNCw0LTQvtGB0YLRjC4NCg0K0K8g0YHQ
vtCy0LXRgtGD0Y4g0LLQsNC8INC+0LHRgNCw0YLQuNGC0YzRgdGPINC6INC80L7QtdC80YMg0YHQ
tdC60YDQtdGC0LDRgNGOINC30LAg0LHQsNC90LrQvtC80LDRgtC90L7QuSDQutCw0YDRgtC+0Lkg
0L3QsA0KMzUwIDAwMCDQtNC+0LvQu9Cw0YDQvtCyINCh0KjQkCwg0LrQvtGC0L7RgNGD0Y4g0Y8g
0YHQvtGF0YDQsNC90LjQuyDQtNC70Y8g0LLQsNGBLiDQodCy0Y/QttC40YLQtdGB0Ywg0YEg0L3Q
uNC8DQrRgdC10LnRh9Cw0YEg0LHQtdC3INC/0YDQvtC80LXQtNC70LXQvdC40Y8uDQoNCtCd0LDQ
t9Cy0LDQvdC40LU6INCh0L7Qu9C+0LzQvtC90L7QsiDQsdGA0LXQvdC00LgNCg0K0K3Qu9C10LrR
gtGA0L7QvdC90LDRjyDQv9C+0YfRgtCwOiBzb2xvbW9uYnJhbmR5Zml2ZW9uZUBnbWFpbC5jb20N
Cg0K0J/QvtC20LDQu9GD0LnRgdGC0LAsINC/0L7QtNGC0LLQtdGA0LTQuNGC0LUg0LXQvNGDINGB
0LvQtdC00YPRjtGJ0YPRjiDQuNC90YTQvtGA0LzQsNGG0LjRjjoNCg0K0JLQsNGI0LUg0L/QvtC7
0L3QvtC1INC40LzRj19fX19fX19fX19fX19fX19fX19fX19fX18NCtCS0LDRiCDQsNC00YDQtdGB
X19fX19fX19fX19fX19fX19fX19fX19fX18NCtCi0LLQvtGPINGB0YLRgNCw0L3QsF9fX19fX19f
X19fX19fX19fX19fX19fX19fXw0K0JLQsNGIINCy0L7Qt9GA0LDRgdGCX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQrQktCw0YjQsCDQv9GA0L7RhNC10YHRgdC40Y9fX19fX19fX19fX19f
X19fX19fX19fX18NCtCS0LDRiCDQvdC+0LzQtdGAINC80L7QsdC40LvRjNC90L7Qs9C+INGC0LXQ
u9C10YTQvtC90LBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQrQntCx0YDQ
sNGC0LjRgtC1INCy0L3QuNC80LDQvdC40LUsINGH0YLQviDQtdGB0LvQuCDQstGLINC90LUg0L7R
gtC/0YDQsNCy0LjQu9C4INC10LzRgyDQstGL0YjQtdGD0LrQsNC30LDQvdC90YPRjg0K0LjQvdGE
0L7RgNC80LDRhtC40Y4g0L/QvtC70L3QvtGB0YLRjNGOLCDQvtC9INC90LUg0LLRi9C00LDRgdGC
INCy0LDQvCDQutCw0YDRgtGDINCx0LDQvdC60L7QvNCw0YLQsCwg0L/QvtGC0L7QvNGDINGH0YLQ
viDQvtC9DQrQtNC+0LvQttC10L0g0LHRi9GC0Ywg0YPQstC10YDQtdC9LCDRh9GC0L4g0Y3RgtC+
INCy0YsuINCf0L7Qv9GA0L7RgdC40YLQtSDQtdCz0L4g0LLRi9GB0LvQsNGC0Ywg0LLQsNC8INC+
0LHRidGD0Y4g0YHRg9C80LzRgw0KKDM1MCAwMDAsMDAg0LTQvtC70LvQsNGA0L7QsiDQodCo0JAp
INC60LDRgNGC0Ysg0LHQsNC90LrQvtC80LDRgtCwLCDQutC+0YLQvtGA0YPRjiDRjyDRgdC+0YXR
gNCw0L3QuNC7INC00LvRjyDQstCw0YEuDQoNCtChINC90LDQuNC70YPRh9GI0LjQvNC4INC/0L7Q
ttC10LvQsNC90LjRj9C80LgsDQoNCtCzLdC9INGD0YfQtdC90L3QsCDQuNC70L7QsdC4DQpWbmlt
YW5peWUgUG96aGFsdXlzdGEsDQo=

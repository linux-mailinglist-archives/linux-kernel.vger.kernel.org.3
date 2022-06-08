Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244E7542E96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbiFHLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiFHLBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:01:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEDB1A04BA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:01:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so32601113lfo.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cwHCFxNZfdLDfyPThL+uTO+4unUHZXMe5v3cBT1R5wc=;
        b=HI0Y7ZDl1CjjeOuPScQ5Jdi7lmUhowfjQLFgLgrSUE3CyFBgp3MVFHFzA8JUYZpPSt
         vhSjkEVl0BF+QDzSSOrK+Trjig+vFz5lmydNotJLSH8ZNWtv9dOh2dXGQi9XTIDL3oYa
         6idfVv0T279NOI5EPJh50ep8CqzT6Tin9KNepPQqFLb540k8jVl4whi4b8bl3BKjoslW
         2qCtoDHfa01iJSTAOlGMeOudoVwSf+ZvwVEy1IDVQMaaqQyeBKhtgCn0UCJKTgaFxxHV
         GgmTDAtVxr0mO8ZxAT2f8uiBo7oZoc6432cm8Gz07rjGIjZczqXVrdz1+sCWAUrfBo0s
         fc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=cwHCFxNZfdLDfyPThL+uTO+4unUHZXMe5v3cBT1R5wc=;
        b=8EQ6mMkoPSP1rhrynMfL8IFD+AJMBXRpD1Og9hf9y3TfYJwTRbwYPV/ikRWG/TN4TE
         g3cOhjlVegtg/u9r8WPzmFoqj+/Qz5PEM6SSExCmXfKc5ukQJEQoQvqiXae+JjhAc2lQ
         X6kcMHz0ISRTcYwe6T1QLq6Zf45tA0Lw9Kt4IfKOPb1Mas0AAIplE5TaJxE0LciWMjig
         gGmLstizoW7XVz85T99i+q6e1unmsnQG0u9IsS23DDd+WWA1BTjHnjLFME7ux++HDrCm
         y2hIX7kh8PpwBeboARUZxW3Szdln8/jPbFPCmT8SxPbIEfnZV0lp6PuhDjFhRXi7lElI
         PlAw==
X-Gm-Message-State: AOAM5334/oCi9oqC822vmiV/nsEui/D5JIXBoNt4/PVQzKX5uA3/JJt0
        Iagu/jkyyMJXkVOq9kIlEp6uzWzLi3/BJs7dsYs=
X-Google-Smtp-Source: ABdhPJyA45nnjxRsjGGllIwGUJj1Rak9jJRwGMzYbOT1C1CY1CUBHGj2wOFmpF7LFtqq/aHsHc7RxAXvBqr+vevo7e0=
X-Received: by 2002:a05:6512:1043:b0:479:4e68:9c6c with SMTP id
 c3-20020a056512104300b004794e689c6cmr8500235lfb.246.1654686063804; Wed, 08
 Jun 2022 04:01:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:c3a1:0:b0:1f2:b9db:65c with HTTP; Wed, 8 Jun 2022
 04:01:03 -0700 (PDT)
Reply-To: alifseibou@gmail.com
From:   MR MALICK <anubis14172@gmail.com>
Date:   Wed, 8 Jun 2022 04:01:03 -0700
Message-ID: <CAJRrMJmaSv9usjoW83yERJx4O+fNoa3foXcADgaeQLYvYHrWbw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JLQq9CY0JPQoNCr0Kgg0JIg0JvQntCi0JXQoNCV0K4uDQoNCtCS0LDRiNCwINGN0LvQtdC60YLR
gNC+0L3QvdCw0Y8g0L/QvtGH0YLQsCDQstGL0LjQs9GA0LDQu9CwIDIgNjAwIDAwMCDQvNC40LvQ
u9C40L7QvdC+0LIg0LTQvtC70LvQsNGA0L7Qsi4NCtCh0LLRj9C20LjRgtC10YHRjCDRgSDQsdCw
0YDRgNC40YHRgtC10YDQvtC8INCt0LTQstCw0YDQtNC+0Lwg0KDRjdC50LzQvtC90LTQvtC8INC/
0L4g0Y3Qu9C10LrRgtGA0L7QvdC90L7QuSDQv9C+0YfRgtC1INC30LTQtdGB0YwNCiggZWRhaGdh
dG9yQGdtYWlsLmNvbSApLCDRh9GC0L7QsdGLINC30LDQv9GA0L7RgdC40YLRjCDRgdCy0L7QuSDQ
stGL0LjQs9GA0YvRiNC90YvQuSDRhNC+0L3QtCwg0YPQutCw0LfQsNCyDQrRgdCy0L7QuCDQtNCw
0L3QvdGL0LUg0YHQu9C10LTRg9GO0YnQuNC8INC+0LHRgNCw0LfQvtC8LiDQstCw0YjQtSDQv9C+
0LvQvdC+0LUg0LjQvNGPLCDQstCw0YjQsCDRgdGC0YDQsNC90LAuINCy0LDRiA0K0LTQvtC80LDR
iNC90LjQuSDQsNC00YDQtdGBINC4INC90L7QvNC10YAg0YLQtdC70LXRhNC+0L3QsC4NCg0K0KEg
0KPQstCw0LbQtdC90LjQtdC8Li4NCtCzLdC9INCc0LDQu9C40Log0KHQsNC80LHQsC4uLi4NCg==

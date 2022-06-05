Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0B53DC33
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbiFEOU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbiFEOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:20:24 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B09483AD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 07:20:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d22so10264078plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 07:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=j9RAT2rag6J8SvU6JU4joFPKkz3/H1X0CZPJ/7flQzE=;
        b=QG3fiLU4cxoWjNzXXtx5S5GjoS3+w3IjQ20FoMGVRDxGoTdjCVMOi0ZVx6GhnwhxIM
         Sri72dY1PGgdqOCbwrk5Y1bmTgt/4ztmx7wdsGOjC5s8qwUhdeZK58+YB01WfQUAuiZX
         kcj9aaG+z0EAiUB2psm1TJByDLwdp8OGVe4DvU02I2mjpOkILytVwE4Yt1uBiFF6sPs9
         VrzA7mMeEuwtmrftWUPxxQ54xPmZ4cbXG5q63XQOZIZjlSKXhrDBktiiaD3t3AIRDrb4
         bmRiE2AgBLtp+nCxSdusN4YWcfdPkf+HdMSXuUjsjc24ggRrm5yJb3j0KG9YYA3Uhs61
         1N/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=j9RAT2rag6J8SvU6JU4joFPKkz3/H1X0CZPJ/7flQzE=;
        b=oCw5OeGetX/LtvsgDxrDcrJlD9h1df5aIIuWZMx4p6ZAt62Iitu0VCXNaCkfOXmpOE
         1orYloedbloDFjXop9ARPZVikdNJ1CPEO8TWklpNXlJVpB6gLcyo+wFaDlmpHQkkp1Jt
         YUW5S92v2g5sd+E6QieqkZWbFUitzTa/vHFI6PHromDy0AyxjlSrMsDvMzXQr68Eme5l
         aCdZ39ubn4Q4ct5rtL4gOXDj6QngL6B2hNtAsDGhikQOE2ISsSlMJtZiRa9PmqStahd7
         o4poQa0tNjwtop7aDNFJ1xwUdBB64MFyhM4fx+GKETalUnM/A4qp2hqAYNsXSx8AHdAB
         n+yQ==
X-Gm-Message-State: AOAM532BBjCmUm316Wsfa6qtDbAKj0qzQo+WUfd3XxHT3ByiL+VeRjmV
        BHR73rEa3ZP2q8ZeOOUv/go=
X-Google-Smtp-Source: ABdhPJxFVyZ5+mC+goSjU5md9Zs82G+jPDdeUhsD7TYhDNIX9f3Jlk1gq6zuDqk6gMwsfEf0loBxEw==
X-Received: by 2002:a17:902:d653:b0:163:78e0:552f with SMTP id y19-20020a170902d65300b0016378e0552fmr19733827plh.63.1654438822810;
        Sun, 05 Jun 2022 07:20:22 -0700 (PDT)
Received: from [103.114.104.3] ([103.114.104.3])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902d5c200b0015e8d4eb2cdsm4447426plh.279.2022.06.05.07.20.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 05 Jun 2022 07:20:22 -0700 (PDT)
Message-ID: <629cbba6.1c69fb81.b5588.95c0@mx.google.com>
From:   "Ms.White Barry." <ecosystem.manainc@gmail.com>
X-Google-Original-From: Ms.White Barry.
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Please discontinue
To:     Recipients <Ms.White@vger.kernel.org>
Date:   Sun, 05 Jun 2022 07:20:12 -0700
Reply-To: whitebarry@programmer.net
X-Spam-Status: No, score=1.8 required=5.0 tests=BAD_CREDIT,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TO_MALFORMED,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commissioner for the Reduction of the National Debt
UK Debt Management Office.
East cheap Court
11 Philpot Lane
London
EC3M 8UD

Attn:


As you must be aware, I am the Controller General for the Reduction of the =
National Debt in the United Kingdom. I am writing you with regards to your =
stalled funds transfer you have been expecting from the U.K. For your
interest, I would urge you to accord this correspondence your full indulgen=
ce and attention, as you may likely have been receiving other emails of sim=
ilar contents from the numerous fraud syndicate and impostors. The authenti=
city and difference would be evident in a moment.

I was specially instructed by the Office of the Prime Minister to embark on=
 a personal review of all long pending and stalled International Transfer F=
iles of all Banks Operating in the United Kingdom, including those at our O=
ffshore Foreign Correspondent Banks, with a view of redeeming genuine cases=
 of Transfers, and consigning others as bad debt in the Federal Budget. The=
 office of the Prime Minister has mandated me to ensure that all genuine cl=
aim and transfers are paid.

The Government of the U.K took this major step in addressing these problems=
 of all stalled transfers as a result of the global financial crisis that h=
as affected banks by establishing an autonomous National Debt Management Of=
fice (NDMO) to take over payment responsibility on behalf of all banks oper=
ating in the UK.


The creation of the NDMO consolidates debt management functions as a result=
 of the global financial melt-down for ensuring proper coordination of all =
payments emanating for the U.K. The NDMO centralizes and coordinates the co=
untry's debt recording and management activities, including debt service fo=
recasts; transfers payments; and advising on debt negotiations as well as n=
ew borrowings.

It also provides for the establishment of a supervisory board that has over=
sight functions on all banks operating in the UK as well as endorsement of =
strategic thrusts and policies for the organization,consistent with the bro=
ad policy objectives of government. Your transfer file came to my attention=
 just this morning, and I was compelled to take special interest in your tr=
ansfer because of its peculiar history of procedural inconsistencies and un=
authorized payment approval documents
that are contained in your file. Obviously all the persons you assigned to =
process your transfer have proved to be fraudulent and incompetent.

Simply put it that some management of the Bank have tried unsuccessfully to=
 smuggle your transfer through a non-existent back door, while impersonatin=
g the offices of various government departments before you,
and feeding you with forged transferred document.

Consequently, I have this morning ordered the heads of all the relevant Gov=
ernment Departments genuinely involved in the foreign transfer protocol, in=
cluding the Treasury Department, and the Bank to suspend all further action=
 on your transfer pending conclusion of my personal investigation into the =
actual reasons why your transfer has failed to date. Official memos have be=
en issued to the relevant departments.

However, preliminary evidence shows clearly that these fraudlent persons yo=
u have assigned to help you process your transfer have been extorting monie=
s from you through concocted excuses and lies, only for them to divert the =
monies collected from you to their private pockets and return back to deman=
d more monies from you endlessly. Please you should not allow yourself to b=
e deceived and extorted anymore. As the Controller General for the Reductio=
n of the National Debt in the United Kingdom, I want to assure you that you=
r transfer will now be processed through the simple,
transparent and authoritative means .

Please discontinue any form of contact with all those you have been dealing=
 with before now, no matter the nature of your relationship with any of the=
se crooks, including your local attorney. My intention is to quickly reacti=
vate and sort out your transfer without any distraction. So you are forbidd=
en to preempt anyone of this contact, otherwise I will be
compelled to out rightly cancel your transfer along others a bad debt.

Reply immediately to acknowledge this advice, and I will instruct you


further.

Regards,
Ms.White Barry.
Commissioner for the Reduction of the National Debt
UK Debt Management Office.

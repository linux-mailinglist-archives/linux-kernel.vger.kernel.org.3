Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096E4585580
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiG2TRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiG2TRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:17:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02F81B3C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:17:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s9so6939364edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=PZfRmFMiSnirqeVBBVxWlchDdb1kwSvD3jvPCqafVew=;
        b=KOEbOoT8LSVdbntQZ+oWcVrfVnU9XCqVztCBdbjeEdeOekWP0k1HvdZeB81vv6vsvD
         kEbpfTDbTUSpa89koiRHlf8tTpIaM1Op+WKC9ru92vUB3vlTRkAsJogYCKJY0hHh6k7y
         CXoTdmuKp6hjCP0xct3GgF5yIfKQMNsOTSQ/jRGBaQ2lSnJF03+Yc0TGsdhQ9DO5bIqs
         vROtW4v5XlQkTKu0LJtxIkI1YhHKbV0qoImgTDjCLKHO31e/Eo23h8vRvQokeI8+J+8U
         FheIOvUXy/0Wo7sLocS8DuugQxISllx6C4YGXg7OPmqIKvfNJOx6MvWDiojToqWXqD+1
         cM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=PZfRmFMiSnirqeVBBVxWlchDdb1kwSvD3jvPCqafVew=;
        b=oHa7+IkDWudGZxTNteUbXbjilNVUKQqF2H9YS9kNIf//3h1me14QaEmEMr2W33y1ma
         RbX7tVYFCPr00PD2Kka3ONRuQSicPgSa2z8sQVzdkH9+aUsNAjtbpBbFp3UF4WNtoXNH
         9V4dDYggQhUQvEoGvpY7xBy1wz2EDQHVnK5FzC39R7Vi/e+/E6RKnXV9hoby8axwf0v/
         dYcNmSOZtVjkHszb8r5y/ST/+XxceVTAD6Cow0z/r/QofL1zdO19sHmBzNzURmGZdVwP
         Q9lzfRDT1PCmjWK7p745u05DvcE3/V7fHvAUuoPyseVWeN+5otcaXFVtqozXJdtu+l9L
         iGrA==
X-Gm-Message-State: AJIora/R2qi7f/v/kSQmNrA7heV7WF6kUFTHRuEHTT/FlP9iR6Z97+/u
        EYMnXY4RGJb6bp5VImUOq8v51JCFlY8d52WRekY=
X-Google-Smtp-Source: AGRyM1vAtu5/7HuzQr++lQIBkPBToA2Fyptfnc/A1ujSPJF1jTEWY2ry5nqlfIclJpopZKd7B1fjyPcTKBIJKJet15U=
X-Received: by 2002:a05:6402:444c:b0:43b:d375:e932 with SMTP id
 o12-20020a056402444c00b0043bd375e932mr4884129edb.399.1659122266054; Fri, 29
 Jul 2022 12:17:46 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: evaristesansan@gmail.com
Received: by 2002:a17:906:844c:b0:730:cdf:678a with HTTP; Fri, 29 Jul 2022
 12:17:45 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Fri, 29 Jul 2022 19:17:45 +0000
X-Google-Sender-Auth: K5RwZmxthOosYFJ0V42cKtJ4NhU
Message-ID: <CANr+W=Q=JkJnRpWjd49qnFW_SnHpG9Ju8zwOmZehRvqW-ah3BQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ciao, hai ricevuto i miei due messaggi precedenti?

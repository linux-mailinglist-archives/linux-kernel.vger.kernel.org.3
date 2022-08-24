Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4B5A043C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiHXWoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiHXWoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:44:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AA37F121
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:44:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c2so16954645plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=rWrcfqthh0R6JOPNpOaNK3PZSz6XORQ8YeJPmURtEvs=;
        b=oEPd9OyFPPwhmU31Yc+gGTAcyPokZnm8WVBxyCY1jggBIE+fwIDvQC2MjuWnkWT21L
         nPxPO/u+2eo29UagjKviNLEMlbhvbVOeGWQFdg1aZz0JLo6058I04Hm0Jm/+nKjTCJTn
         R/d87FvdZUk+jQ31ywirrUiAeF/Nf3mUyDapV9k1PobuEmpamVPu+SLy6mnir5rDcnbo
         ndrREadeobvq9D+nFAAjFIH/4NzCnc3jFDDOdEf8oWZ9l7wDrzdM4Sulg6m6UxKmo2w3
         eJJo+ZI3TeUI4MJVSZUMNSG+XxLIB3FY0Mxgmce/OxsJo4lsYTK8fTl5Z4M/mqDW8dSg
         LXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=rWrcfqthh0R6JOPNpOaNK3PZSz6XORQ8YeJPmURtEvs=;
        b=WNUKn3aLcQ81TE+2Xc6rB8Bqh1dNaWlK4pAtjnMx+dTwTkNxxW2Oitn92lX3HE+XHV
         NcAUgMzMm18Nud+up1H7HBFyxUg5ew5T5MphVu1q+PIjImztwGWvOV7BHlbu7+A4Orqe
         6/WjxkC4uYsKnpMdk5Quzoc2lGohI6aCPbl0mUTObj1JjCU3ZCPuVSAQUxVq9nN5QWXw
         klxLC7B7BOvEzOC8+EHyWtzonK7qg478shQipIRvUppO3Ao5FbWSE5RsJsgKDJn1CTWd
         zLHp+sXswd6r9zhFY67iSvYxBsWcfCYNG374Rm0oTYYY3OZoYe9v/JyglwmXcFfXMLLU
         ESew==
X-Gm-Message-State: ACgBeo1+JAHTBD04slZZR7d4Gmn6M+Bhr61xpBR3Ht649/iqSGDvKL71
        Cp60F4x99vx6vX2ukjPrKDieHrY0/6LcZjcdcpA=
X-Google-Smtp-Source: AA6agR4JnsQJG4o40vNDKryjLIuPhcoWqYnSgc2qVdiOT18cLrchaNtBfbTCE4ZuXoy0bg+HISdrqdxhlk/IDE07Lhs=
X-Received: by 2002:a17:902:9006:b0:172:927e:c19a with SMTP id
 a6-20020a170902900600b00172927ec19amr935257plp.162.1661381046231; Wed, 24 Aug
 2022 15:44:06 -0700 (PDT)
MIME-Version: 1.0
Sender: lawanyauabdullahi533@gmail.com
Received: by 2002:a05:6a10:ed1e:b0:2d7:449b:2a7 with HTTP; Wed, 24 Aug 2022
 15:44:05 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Wed, 24 Aug 2022 15:44:05 -0700
X-Google-Sender-Auth: ym2vAdbffHxi8YliSnXbrYRXSuM
Message-ID: <CAFLNib+RUgPr_z4P-qGyZ_=B1ktG3hDjCWx2aiTG4AFcHvCDrA@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you

Best Regard

Christopher

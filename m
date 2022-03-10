Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FA4D3F68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiCJCwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiCJCwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:52:54 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67C7125CBA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 18:51:52 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id j29so2868328ila.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 18:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=KsYfuK1VkY2187XWZIYnjdlUWi8A7SbSiSeQ4aBqm/GWTIFLoT76XyjirAKTdU53pb
         +yrTPnmV10etrPAPlarefR1bNsRzrmQzUyJWCfBQ73Pek+8zvIXOUt/8UgjmD1s1S58I
         PjWE/fzBA9EietNVAMyoMEOViu+5HI2+amNi2lkrrN57wJ3tUPYSqvSBXW2mrZu8YVsR
         A0rCXzKYBNbWOpd1/8LJZNqywTJvB9v3pgmxYVhx3D2Us5iXoytodlForERUkQ8LA9Zv
         s9biZFmWag0oD34HBgroi+x5vBi3UDnDJ/139+kO5l2qG+cyBAdEvFnI+dCl+ozfUO1F
         4HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=VpOy10d+MDKi4Gczfqx3TWE/bgie018MfVYrRnjg00umJRxfykMXHrsfONdMcacYxJ
         Rar0433nxCIQq82+HZfMSvJcicRR+HGKX+iIMMCjQ5qGw118rVcjthf+cd8eZjgaDZV7
         Unw+LfEv9qxYeU5yoXrU7L1WYXIND98APF6WpR9QSZWd3U5TnFumDaaV0mylRUEv35ju
         bHOMhFdyZPlpcYOEicmVJQbNaxL5ARdOfTuqob/nuLV3zORV9cTasAuj9tPA74cpl4Ul
         8D3N5wUf1n09r0cwyjOiadaiu+vOL6eMpNNE3FTrx7V9HOolYx9QOZQ5K+2Lg2HSopfN
         97tA==
X-Gm-Message-State: AOAM5320txfyjN1/aQNupwuzvfDCTv6pcRUJq2n1OcidnZ0UH8uiH3yH
        EaTMrO1RtA0QZCujYa/6qhl/7e9UpHzG3Jgdon8=
X-Google-Smtp-Source: ABdhPJx2un4z4qfwzOitIhIz5NWyd45MqmDNAI7vVb0bD1ZUmZx8dS7T0uZnaZsf9hwDZH1MTlWWKgth8BugPy5pqKA=
X-Received: by 2002:a05:6e02:1be1:b0:2c6:7395:a076 with SMTP id
 y1-20020a056e021be100b002c67395a076mr1900024ilv.143.1646880712320; Wed, 09
 Mar 2022 18:51:52 -0800 (PST)
MIME-Version: 1.0
Sender: albertgearldo78@gmail.com
Received: by 2002:a02:b11e:0:0:0:0:0 with HTTP; Wed, 9 Mar 2022 18:51:51 -0800 (PST)
From:   "Mrs. Latifa Rassim Mohamad" <rassimlatifa400@gmail.com>
Date:   Wed, 9 Mar 2022 18:51:51 -0800
X-Google-Sender-Auth: _kE8gKEgw4vbJ2Oy6Kh5dYw8Y2g
Message-ID: <CAPo9qzONus-Exxr+cwFBfvvdxj_YexUnJ_N5gd3UJqXNitesBA@mail.gmail.com>
Subject: Hello my beloved.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings dears,

Hello my dear Good evening from here this evening, how are you doing
today? My name is Mrs.  Latifa Rassim Mohamad from Saudi Arabia, I
have something very important and serious i will like to discuss with
you privately, so i hope this is your private email?

Mrs. Latifa Rassim Mohamad.

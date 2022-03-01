Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271934C8FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiCAQEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiCAQEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:04:04 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DBB4D242
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:03:23 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hw13so32362794ejc.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EnSVDUYpootVmvlEv/j8IqlXisX/SLOnK63+EyOQLj0=;
        b=KT5ytx/SxYfDHmNMvNso7+iyDKbif3sQNtRW8KKjdhjskgaFyzWcpCO2htDTTGuiqp
         KduicdTUdE7db4G/Lh6gbVL1XlSV6pC6C8uffeAsQ09H5ejYudugkBL1HrAKJtLIWD8N
         ++9LLL++vCZ7/WIvqZEQNAQnsf8BNMZec3jdbb/MjC3tF0CTG+Q9ZCjQFGAK4oPFqyk1
         u49HbzbiVbr5MY86SB7VRKuxSQUEXwv4QMrhKzp8YiEgnG56abCJBW6DUXTiePt2Lcux
         s4wwh80mZH8l1e0fjpJFhnudFjmNnnlXgYGi92tm+sagT9guGRhay+6ZJvUqvcGDEXeJ
         AsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=EnSVDUYpootVmvlEv/j8IqlXisX/SLOnK63+EyOQLj0=;
        b=Mjl9IkZvZsdO+X6KsqDwyRM6xHDI5/aUCmtrVq5b+kUnQWszQvegMToegUnjg3+DrQ
         Zo1TVkrIkLrLCGeo/qhUCPrCw8wlqxCGglqI1C5VsU+aEdKdjAV/RL+apZN0O2lYuHk5
         YlxYtBKOAT3PHQ8Rm1mpNgPSTHvG6vsqEx5HzZVlwW1loZ+wFGjhlY0MqVJXCXyQ7UaC
         vsa+nQcMwG5SRHwVbEn9QvHzc1/o0U9tl5LYE1X/s5PRG3hbrHMOgIV60KN7g8NHIqL+
         ds7euRuGAaOBAc28dYBe7R9VeISu7CLLXRv0+uZ5B5hF2mBBjl8pXMjy+NS/kpIQoxl/
         jf8w==
X-Gm-Message-State: AOAM531f9+uF6+sYYYxpQ6GEL8YreW4gKRVy6juZ37+LzzA+Moos+JuF
        uV5GvBL/L4zzjvLFY3DL7szg/tkQVh9/tbx/JrY=
X-Google-Smtp-Source: ABdhPJzs3xd2Gtf+3gshsUQ6UMizvrifZnyqzo2dzlJ97le9gNQuvPGhn0QOtbr2XyDoK94p9RHxoR36H++MTLx1FzQ=
X-Received: by 2002:a17:907:38f:b0:6d6:e5c5:6dd4 with SMTP id
 ss15-20020a170907038f00b006d6e5c56dd4mr2479820ejb.705.1646150601710; Tue, 01
 Mar 2022 08:03:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:368a:0:0:0:0:0 with HTTP; Tue, 1 Mar 2022 08:03:21 -0800 (PST)
Reply-To: sgtkaylamanthey50@gmail.com
From:   Sgt Kayla Mantheym <robertsonkodjo01@gmail.com>
Date:   Tue, 1 Mar 2022 16:03:21 +0000
Message-ID: <CAOpP-mmLX-fzqCyXdsDQnOmcKvbe_P0NSS9k+vTbJW_s4MpmVA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

w4luIGlzIMOtcnRhbSBuZWtlZCBlZ3kgZWzFkXrFkSDDvHplbmV0ZXQgMiBuYXBqYSwgZGUgbmVt
IHbDoWxhc3pvbHTDoWwsIG1pw6lydD8NCg==

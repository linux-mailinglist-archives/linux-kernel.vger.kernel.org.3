Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E538F517813
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385578AbiEBUaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiEBUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:30:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8529FE2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:26:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k126so5432858wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=matchdayarena-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:reply-to:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=lJ+KH0aRdl8k8CwFrYo0ipoiGK0sWPv66PH3fZBi6XE=;
        b=G1eWQAqHWkwMyCp6DGl0+lJAyVpDdF660ofb2j+dHM8+vYDizJS2KqFMTzeSh7Q1ax
         WNAl7+3No6iLJ4iYPe5YIyMdTswEHbYwz51+yjdpVIUVVgXLnWdj1KnWINgTbiLBaP47
         xrvpQfItRJ/wjr29rR/O6YYFE3zHqRBIEss+6b8WW2EBsSztBqgiAdECA0pZ2+gkvSb6
         XvQbYwYma89BPbx8nE/1+K/WQjPLMZ3u48CcAnFqbRlFIzT5WYCDAJfgWIujdNGC7pj+
         oM+gmjO77jmkzZ9Wl7rFmEsTKb+YQgFjUbZyGzKL7IbjK3oEAkjoEu6CstooEjbPRqHJ
         uYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:reply-to:to:subject:message-id
         :mime-version:content-transfer-encoding;
        bh=lJ+KH0aRdl8k8CwFrYo0ipoiGK0sWPv66PH3fZBi6XE=;
        b=w2wwhNuMsMyAhUHwZWBqo5g9AKxwIefX4xB+diaXvSPRhy0HGIWAz0NK7Nr+KC/c+h
         bh80OEbxLM1QoK1Od8PgKfVTib6SOGnPdkmZ0w7pYK2B8UYvHAKuTLUR4bKTHflCMU6f
         5sd/LKEEGbTlrasa1GVQCUtbuvh983elFXxVVW6lWd5grKpcGUjoSjcyRM+2rh/DihSR
         zvZRHmc8f3O+lJDYObL9//Pe8s4t8quY1RVvi2tbeISoe0DLRoyMgCVbRciBqxSKFJdD
         2nICEdI+iEblLBZcYe+kULbGHD/cr9eQKxSnGLRokozP3CMAhS9k+x2/vI5jDZcFMcbS
         /Atw==
X-Gm-Message-State: AOAM532j7yPlVoJn5XEu79ujLQRBscCn4qvHtcgCdjAE5I/o/Z37VqZW
        eOPPE2NagnXAolgFXrPV9AIwrFKh4MegAGVUaq2GanHZ
X-Google-Smtp-Source: ABdhPJymaRxNk23Iz4XOLMvAMyaxBHlfUxXuVf3jFb58YgRU2Xd8MpKJHmk3O8MkNDd333ivEV4s7g==
X-Received: by 2002:a05:600c:4994:b0:394:dcb:d66d with SMTP id h20-20020a05600c499400b003940dcbd66dmr609479wmp.178.1651523215468;
        Mon, 02 May 2022 13:26:55 -0700 (PDT)
Received: from localhhost.com ([41.218.193.3])
        by smtp.gmail.com with ESMTPSA id l3-20020adfbd83000000b0020aca418f26sm7943969wrh.1.2022.05.02.13.26.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 May 2022 13:26:55 -0700 (PDT)
Date:   Mon, 02 May 2022 13:26:55 -0700 (PDT)
X-Google-Original-Date: 02 May 2022 20:26:48 +0800
From:   RGICOMPANYLTD <no-reply@matchdayarena.com>
X-Google-Original-From: RGICOMPANYLTD<Admin@localhhost.com>
Reply-To: rgicompanyltd1@gmail.com
To:     linux-kernel@vger.kernel.org
Subject: Greetings
Message-ID: <20220502202647.8BB3F87241F888A3@localhhost.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RGI Company Ltd
Address, Netherlands
Call:+3197005033311
02/5/2022

Atten:

RGI Genealogical Investigators specializes in probate research to=20
locate missing funds, inherited funds around the world. We can=20
also help you find wills, obtain copies of certificates.

Recently a woman from the Rothschild family, one of the famous=20
families in Europe contacted our company that we should contact a=20
business minded person who is capable of investing her funds in a=20
lucrative business.

Our service fee is 2% of the funds and we will be paid after you=20
receive the funds. The funds transfer process should take just a=20
matter of days as we have the mechanism and expertise to get this=20
done quickly. Please if you find this letter offensive ignore it=20
and accept our apologies

Warmest Regards,

Dr. J.T Woods, CEO
RGI Genealogical



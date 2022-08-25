Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179D55A17C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbiHYRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiHYRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:12:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C48AA3EA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:12:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r124so8493758oig.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc;
        bh=LcowEz/MHN6VIwZyVyshjW7bqzLnX3nnurMOL1MyeF0=;
        b=cKkmbBix+N3cbmFgCBhnjLIvuq5g14yJ904Eln2mxC6ZlF14pz0erECWCP4txp3xs8
         7S8mpHAkjHlV2vxSqEHaxHMCa8QAgVq4bzsgV5ul5AL+lwU2YSbizVxnl/Bso5/sb0yS
         oOE5GhU30f9zhtX3UCX7n2OJ6l7JUt1vRLYl2VZg6L0y1XmnrouwXeMqe8ACF3YJm+SS
         DnGKiy54WOS5O36rsO4xJ+5eoZnXCTHxTjpGXwP3KAtodAlZSRusSg0VRNWHb4EkSZWG
         xo07mL+XN5RL6uCEcPMBe/C3qF2RmDFAcZ6T29yxbqIXsYigFnF3G0MgFt89mfc7lWgG
         6zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=LcowEz/MHN6VIwZyVyshjW7bqzLnX3nnurMOL1MyeF0=;
        b=aJ2UQtF2/mmv+gQTGPkajw3DyVAiQ6w87R6EFmLbuPNuoORJ3aIB1ECTXff8Qn0rCm
         cnUoy+K18OSQPE9UJtn08Q2h+VdfkNqf9Qq7II059l3+29zzL/OMlFwWoMG2roeMi0HX
         CRtPGiA7hnrtLk7cW+d2LsYqBHFSGQiIjb/lkVRWowLhd/4niU8k+XtewsseveHeRhvK
         fv5LxZKWFSTuh3Dvd96i4p7kIGi8RlwwNGAVvMc1CxiQMjPBPUHzqic7iCipKLG0TgVF
         zGlouHb+vsB9gSlf8vhl76ggD3qwPeaN7SWGH5TbYvMEY0t63BzVfbOQ7/qw4AORK1Y3
         dJhg==
X-Gm-Message-State: ACgBeo1CKCxj6Tzja3ESjj0YTr/fsUDFPfa3/gT9zUEsKxOkAp9tsGAb
        1rVr4vg2rCdKyc17LU2xzHaG2tTPEZThCOFp0TU=
X-Google-Smtp-Source: AA6agR6041ReGowM8y0wztP239SBgQurxNqCOQY3ObWzoJ3F/EOopGhKFI5Vs09LDDeAPO4eGI//4yQH208NchXxpKc=
X-Received: by 2002:aca:1c03:0:b0:345:161:b011 with SMTP id
 c3-20020aca1c03000000b003450161b011mr50053oic.40.1661447556213; Thu, 25 Aug
 2022 10:12:36 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: salifzouli4@gmail.com
Received: by 2002:a05:6838:bac4:0:0:0:0 with HTTP; Thu, 25 Aug 2022 10:12:35
 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Thu, 25 Aug 2022 17:12:35 +0000
X-Google-Sender-Auth: w3QtPfX5IUfmDSH-J_2gO1fZ5yM
Message-ID: <CAFFHfojJZsdbFTbxnGAiX80jZnf7Ewz5EOcPKd-=LtFXwYuoeA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ol=C3=A1, voc=C3=AA recebeu minhas duas mensagens anteriores? por favor
verifique e me responda

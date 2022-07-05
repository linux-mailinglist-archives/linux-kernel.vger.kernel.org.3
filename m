Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6C5661EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 05:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiGEDkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 23:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiGEDkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:40:15 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA311A34;
        Mon,  4 Jul 2022 20:40:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id he28so12077987qtb.13;
        Mon, 04 Jul 2022 20:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=wUQDaT8WbROvuA8fdokHEDXDYlyV+cZbGMOIqIZCVpQ=;
        b=fXj//W47LzecMHz4CDl0quh1U8YS5fzqCycVCQP7AcxnfWb+hb68e3SgG+3naktf6d
         BUquoglGds8xo1pAV1zo8ZnqB3Ab1PWwvoKQoK51XSAoOfAi0YalifiAS1sKs5bDKSui
         2Op25SGABLpJIr/+9MYC7HzhGAzZuITrDneu+bXAPQXE5nRv4Mn2c1jGtTHKaVn4i5kw
         qAhA2ah5iSBFp72o4rjn+dGf05vYa136wPeiSRwmkbXcFLgzfk76pRXDNyM5+fR0PHDx
         eiaicRH0xOZ6z4yp4g00xdrwDJIS2K6I4LlhdajbSniWbkiCFoL5huYgNM6OEzDnnOz2
         iDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=wUQDaT8WbROvuA8fdokHEDXDYlyV+cZbGMOIqIZCVpQ=;
        b=Xc+L+Ejaw2zeHY532wiVwM9Kumt57ZU2ZTQr+hw2XU39s5N6pgzU3o4NKUH8NhPM2p
         02anIGTwqy7Twb1viOya31ClMBQUJuAtmJj0gEfBxRIER7WzdC5QaqbimtNRDMw5bONl
         SdpWm0awN62gL8SrHBpeTGEvG1CT0jkx9fqm5/Z7V479aqzGzAo6VdmLI0snB+Qdffzg
         Wb43pzBVx3zQDC61FmSuXzNYpW/QACAyv/zzH+fG0rZS/rXdb0imw3H65Grylgfyxsjg
         cEOF+mvMqf4cgJQb3Gz0cC4WCfoVN4jeuEGEjgDPEA/mEU6bdknuKVHEG37h4kl0gVKV
         zJ0g==
X-Gm-Message-State: AJIora9PTV2I+n8pq1kqdbDNLP5625dkG2kJPBbHkDQ4ecXIM85ONVSH
        j7D+cq+ffGSvAj3FQEpEoRHG2QSA9NHl1fv+
X-Google-Smtp-Source: AGRyM1t73dL36xuKZX4Pr9rWwwSNkdoKnDAe7HrrqCKpxNWKHz4TGvPDrQoP4Cn2Onvs6ixGXCRrBw==
X-Received: by 2002:a05:6214:1cc9:b0:473:2f6:22f8 with SMTP id g9-20020a0562141cc900b0047302f622f8mr1543698qvd.22.1656992413900;
        Mon, 04 Jul 2022 20:40:13 -0700 (PDT)
Received: from SCP-85YJ4TJHBRL.226.130.106 ([23.226.130.106])
        by smtp.gmail.com with ESMTPSA id b19-20020ae9eb13000000b006aee672937esm25708318qkg.37.2022.07.04.20.40.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Jul 2022 20:40:13 -0700 (PDT)
Message-ID: <62c3b29d.1c69fb81.3f861.714d@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello From Keating C
To:     Recipients <djryuma@gmail.com>
From:   "Catherine Keat" <djryuma@gmail.com>
Date:   Tue, 05 Jul 2022 05:40:08 +0200
Reply-To: cathketg@gmail.com
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello And Good Morning,

How are you?Just to confirm if,you got my previous message or not,Please le=
t me know,Thank you,Please write me back so that I can Resend it again to y=
ou.

Thanks.
Catherine K.

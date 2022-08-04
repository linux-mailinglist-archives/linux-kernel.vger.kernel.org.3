Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D89758A3CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbiHDXIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiHDXIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:08:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B39E1E3FD;
        Thu,  4 Aug 2022 16:08:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv3so1385978wrb.5;
        Thu, 04 Aug 2022 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc;
        bh=+ElDsm7N+LBw7xETToduf1RcvU9bYLaEIprNs6yrJOg=;
        b=ZP9xg5PRIrTk1XsrOkgn9OuhDioeBCEfse9XDrrHieUikWuPeYVnQX72cnwQNDkoRV
         yVFXBI7TFoeal9bJfOipTYlAxjHeNqxQKYlzWcVJJfwHKKxwB3l6pAsmyKMh5Iez4aKd
         0vJDzqfbfu2otvaWc5wD/G4RvTZpx1js8VGRFYE4hKi6C+y9SrIMS0nKw1Uc/Pg5p5Tz
         +ppJYPBdeRJe6Dxh5iIrbd1cR2T6zQoMDDlbQPpPLFrwzPuFMzLIzBsmMZgoM1D09TqI
         +7jU4TDYW2O5X3DxKIo3mNDaFu/T5/lXJisL+boGiwCyDJB8Y0/AzFUIuM6AlY1MgjZk
         6mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc;
        bh=+ElDsm7N+LBw7xETToduf1RcvU9bYLaEIprNs6yrJOg=;
        b=7V2CuNNP3hY8Skoq+IuSRp3VHRqDSXC7rWQXt97IB9TNz6MRS8f31IwaO15cV79io1
         1tzaKiHNpWlBxvcKG+f8Bvm8n+J4HoN/KD5haK/oXl+M5c4HI54PX9dIqklRnnerJ64n
         fPk2gWi0uvwQFsQTyl0KrtKBJdWVLua7SaysHK6P5WTy//cj5j1m/32i9tD3JjS/YuLV
         vBZXraH/dIozNAPzYwDRjiD7WNUWFIPy0sjU0PT649lHqhpBFcf/u6oHVI/JsbYpF2iU
         1CyU8MUpDFaFL4VtJRCeJYgpFj9dZEzCQ9nsjE9BZLCtWy5hP4npzL7vJGftPZSXLmqS
         +kFg==
X-Gm-Message-State: ACgBeo2T2BS8WJzcBexkrVCiIYpNPsnd6qgMdPpx+/EOBN2Z9L2KASGi
        0WqvLdgGqSZwmJDzt9qML/Gk+YSTgzSgTHg92hE=
X-Google-Smtp-Source: AA6agR7HGVRgjgUt8wmmepOzUtJL6HOwaUXnuV31jCdwJt4yvwvkT9FYGhISLV5zLOgvtz5U7r0cPQ==
X-Received: by 2002:a05:6000:168e:b0:220:87da:c3e4 with SMTP id y14-20020a056000168e00b0022087dac3e4mr2506310wrd.559.1659654479798;
        Thu, 04 Aug 2022 16:07:59 -0700 (PDT)
Received: from localhost ([84.255.184.16])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003a2ed2a40e4sm8736004wmb.17.2022.08.04.16.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 16:07:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 05 Aug 2022 02:07:51 +0300
Message-Id: <CLXMEQRZRKJH.196H3FP8VFR8B@Arch-Desktop>
From:   "Mazin Al Haddad" <mazinalhaddad05@gmail.com>
To:     "Mazin Al Haddad" <mazinalhaddad05@gmail.com>,
        <linux-media@vger.kernel.org>
Cc:     <mchehab@kernel.org>, <linux-kernel@vger.kernel.org>,
        <skhan@linuxfoundation.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <syzbot+f66dd31987e6740657be@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] media: dvb-usb: fix memory leak in
 dvb_usb_adapter_init()
X-Mailer: aerc 0.11.0-85-g6b1afc3ae3d8
References: <20220724214100.593287-1-mazinalhaddad05@gmail.com>
In-Reply-To: <20220724214100.593287-1-mazinalhaddad05@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, did anyone have the opportunity to review this? Any feedback would
be appreciated.

Thanks for your time!

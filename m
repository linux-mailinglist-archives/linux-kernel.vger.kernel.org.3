Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0121F51306B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiD1Jwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348940AbiD1Jmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:42:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8A8972B8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:39:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d5so5953822wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to
         :content-transfer-encoding:user-agent:mime-version;
        bh=6ZKHGiDRzRbPXQHyr5VeHk6x4y/gIT70tGEEovHIImo=;
        b=PeHfrQr7jWNTLtX4c68wBxngwOTuc6NMSZlesvJOJtSY33jMGK1xGMQsMiFCXinjGw
         MS75GZe+n0mkK44PFTKNmKnl3KJN8OqrtQp59FO5P7sTHkcbRqSjAyfeULI6ezborhrm
         E+nHrGb2E8hBzTAikcfkXLMhQCLXNnONjR3+5xgcJq6D8ZBEw8iPxVpG+Ap9iC7B0fK/
         fnPsJHVIjwfdihDqsFnKv2Qtf/KhJexR5uFwI6pNDTLPEO+klzuh7npnpSvnShNvbGbs
         LS1tbiRj8GD3fy6nPgsFHtOWDN3P5u5FBS0b612O7SgX+7vA4WTLb3w+G5+R9a428qf8
         SS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:content-transfer-encoding:user-agent:mime-version;
        bh=6ZKHGiDRzRbPXQHyr5VeHk6x4y/gIT70tGEEovHIImo=;
        b=EgCwEgu3vK3ZNVR2etdDNsvPMtzlAUF61K34oJ6jGa1jQhHc0Ir3/vWITySw3X6MoB
         /jP55BkmY4KquD+5MTn8X9OMSdNdakJ0nkoufuhUoZ3/8XuEBYcTOamQd8tMKOUsQ/Sr
         4dCWgZPNi5rncRA8GEq1/PLGm+EF3i4rbH5sPwu+NCOd3iwBEzInSOlA3vbM/0/bUy47
         hltrMczJLiVBdGZ/uZTH3l91sLMU6uXO6VnVKaf2myfmuIlllbdylO8zneVMkNmfXrlL
         H7ao00yxTWnwBDPYuT+VV+JkcOhvx5vtJljiFh5QRiFs1u/8znkbBSDHS0N4dqnN3z8U
         HfVQ==
X-Gm-Message-State: AOAM530BP5IUullUlyryHfWTY443O/FfWomgScQI7CWP3ltgm0RuWilA
        +SOIewokJRcBC/mHHDcgg9Q=
X-Google-Smtp-Source: ABdhPJzq8Avm5kj5cxYcajFINUiU3+GPuk/6MpZQ3CFwCbRNxAjyTyWjHfcLKbugSSXMG2vEJZ97dQ==
X-Received: by 2002:a5d:59af:0:b0:20a:e9e7:5c12 with SMTP id p15-20020a5d59af000000b0020ae9e75c12mr8781894wrr.572.1651138761316;
        Thu, 28 Apr 2022 02:39:21 -0700 (PDT)
Received: from ?IPv6:2a02:587:7e0b:5403:d800:75d5:89c1:5d9c? ([2a02:587:7e0b:5403:d800:75d5:89c1:5d9c])
        by smtp.gmail.com with ESMTPSA id o21-20020adfa115000000b0020adea2767csm8944012wro.83.2022.04.28.02.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 02:39:20 -0700 (PDT)
Message-ID: <14ca7a53c11effb4e4f711b0dee60ebf041884b0.camel@gmail.com>
Subject: Re: NTFS3 driver is orphan already. What we do?
From:   Leonidas-Panagiotis Papadakos <papadakospan@gmail.com>
Reply-To: CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com
To:     torvalds@linux-foundation.org
Cc:     almaz.alexandrovich@paragon-software.com,
        christian.brauner@ubuntu.com, djwong@kernel.org,
        ebiggers@kernel.org, hch@lst.de,
        kari.argillander@stargateuniverse.net,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, tytso@mit.edu,
        viro@zeniv.linux.org.uk, willy@infradead.org
Date:   Thu, 28 Apr 2022 12:38:48 +0300
In-Reply-To: <CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Linux has to avoid having 2 unmaintained drivers, wouldn't it be better =
to
remove the old read-only one from (I think) 2001 and keep Paragon's version=
?

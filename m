Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB21462669
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhK2Wvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbhK2WuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:50:18 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3FEC09E288;
        Mon, 29 Nov 2021 12:21:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i5so39465754wrb.2;
        Mon, 29 Nov 2021 12:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mx9qEVTc5L7LG+KTFa38pYVxJTMlpW7T3RqXjyy8SgE=;
        b=JEgzYXdEFtQzc/qzqJnUGeId/zNqgRHsnRaNqgiV42FmkoWOaO47gS3YlUD7By3aPx
         4fM6wuc7HgKJxEK29It8PX3eK7QmTYQjiNciWvw+FC4pZU5RNx7pJzcP1zpGMjnB+KKD
         j1GertTTS1gHV9zkP5TDcSzyB4GlnFWSedwK8zdEjvW+kOjExwrDVjNFMBZg1MRDiq7p
         QCdnJkiY7HOT0c7JeYFkzIssDk1SPgNsz1f21vNJqdlIXIbmG2CJxClb38WvvyOEFkUX
         j4JLKysQChHEUNgNDnAmk2zUyxCkWUnTnqeYdtk0lzAbYqbS92WMpbAtYR+LemDR6/Ju
         hkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mx9qEVTc5L7LG+KTFa38pYVxJTMlpW7T3RqXjyy8SgE=;
        b=pTDB5FvpGVwRqx0+fqer98I1ZAHkbLK1/uOAGs0WUF9xSrm9CF1xvHwrfPS7NvSufJ
         /u9oN/vr9SO8bV3bHgCadecIVAYwiUUbiGk2IRk5ajOxgtwNs18xRmSAMWvTybL1AzpE
         Jml997Oj35uEPlpy4M6Sd+w3cA4IvF0kqohrkqGgLFVet/cg49o39aGCh9c3DbGiHQIg
         0vTQIWPVCph+LfAGjoyw8XyCRbZnVEAAUHnjjmLoJjJeVxYVPjlF9juyx4oUZ81tyeb8
         eO6eA8Sxe9swQGX887+/lQVqIth+dnQhNmNYlnk9rqjKYm/uEDMbk84dZzkH+6bzhuaG
         uV8w==
X-Gm-Message-State: AOAM5330HeNTX0zy3OIhPx/LluRF15WziB+h/5cEEU4WGaTkz/6RVCx/
        I6H2w79jF/avU4yzeMzalHBN1AiktiyWVg==
X-Google-Smtp-Source: ABdhPJyuROYW5K2myX4AXmpIZRbb+m4J75iyviDYWGFbyy0ZHOtErVr9LudKE3w6vpD4TAbwv4T9mA==
X-Received: by 2002:adf:9b95:: with SMTP id d21mr36284521wrc.527.1638217296897;
        Mon, 29 Nov 2021 12:21:36 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06460b103a790e4c64a8.dip0.t-ipconnect.de. [2003:c7:8f4e:646:b10:3a79:e4c:64a8])
        by smtp.gmail.com with ESMTPSA id g13sm19893805wrd.57.2021.11.29.12.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:21:36 -0800 (PST)
Date:   Mon, 29 Nov 2021 21:21:34 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 0/4] Docs: usb: Code and text updates from usb-skeleton
Message-ID: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explanation and example code updates from usb-skeleton

Philipp Hortmann (4):
  Docs: usb: update usb_bulk_msg receiving example
  Docs: usb: update comment and code near decrement our usage count for
    the device
  Docs: usb: update comment and code of function skel_delete
  Docs: usb: update explanation for device_present to disconnected

 .../driver-api/usb/writing_usb_driver.rst     | 69 +++++++++----------
 1 file changed, 33 insertions(+), 36 deletions(-)

-- 
2.25.1


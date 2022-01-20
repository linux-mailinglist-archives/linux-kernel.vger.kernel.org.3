Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59851494B06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbiATJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiATJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:47:28 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4DFC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:47:28 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w6so5004769qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TzW6TXnfq8OtLTLQdwOY4LZWcnWKKswJe+qqMF/4SPw=;
        b=m1mKkl9myTaee4SiU7O4VqRThd0xRdTn3gdCUwazgZlvibvlLt1n1uHQ/zllKoj73O
         ct5BU89O8nNG5vdCi8B+b0KxcD2fF0x/X/ztOTxbkJfAdvBInYppnLKeEGteLRsAbRUC
         8e93z38uKCX9pxhnKHkobus0eTYUwpTaqZs0fhpUqDjEo4tTxLzaLu2MO1kNBJsAwBfi
         NDheaF4DF3ZMsQ4aoQHFuTbviAe2wWEAldKGTtQ8IWRkYFAjZnHt0rD/84rPb72yWnc8
         iiGOC9HV44qV1PwpohOg48Dn0ZEsSb72KeZnCMPCKJBRmN1dDfADVHjQKuKD62C2ExI2
         RH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TzW6TXnfq8OtLTLQdwOY4LZWcnWKKswJe+qqMF/4SPw=;
        b=NJVS3bYFPXGWcsoU4nIxSd1Qq1c5mhAtaobDsW/Kc8UOZN71J2sJnohLkpG1OI1zVq
         suTSzl10RbSisGQwxlSJQRYvCI2ryu8+Nttte17+AMbFB9mGhbVPWQh/4Ru8QrS7mFBs
         GXHZ+HG9eUVdIRBKFwJvwZDI+Asa8c2vS9WeobiDDe1jjq1PDdmaG9uXeZ+YICh3aeL6
         pDrdwbAziZKz6lPM5AuDYlQR4TDAhQ9wjfvj5eZwYY7x7ohuN/A5Qr/GWlS2UrHetcoL
         goabklKb9zA5Itrv9+gO+LM4FsGx9iA3M5fL34MH/D5KCVJbHCLm3a5qVH6y24sqatMM
         nYxQ==
X-Gm-Message-State: AOAM532+syR0VTo0/yAGQyL1I92QnDRDrpcdNV3oCaSd9ihrt1b7XLLh
        xq35u/8MOprQ90jVmuD5CJro+ZDF6kFM/DsZhA==
X-Google-Smtp-Source: ABdhPJycCDlF2GosCQFkfHm4yXmez58wA/DaQxmTb0Kmeq1v4TT5Aw6GNLSKYyZM7+xTipmwvSGagmHGbzYXjZBE1xE=
X-Received: by 2002:a05:6214:21ac:: with SMTP id t12mr2362436qvc.42.1642672047214;
 Thu, 20 Jan 2022 01:47:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:1ccf:0:0:0:0 with HTTP; Thu, 20 Jan 2022 01:47:26
 -0800 (PST)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <happypalama@gmail.com>
Date:   Thu, 20 Jan 2022 10:47:26 +0100
Message-ID: <CAJoenex49-KWJw+7c75XELy933p4-AdEcecckFwt8pKbKkukKg@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQpJIGNhbGxlZCB0byBrbm93IGlmIHlvdSByZWNlaXZlZCBteSBwcmV2aW91cyBlbWFp
bCwgcmVwbHkgdG8gbWUNCmFzYXAuDQpSb3dsYW5kDQoNCg0K7JWI64WV7ZWY7Iut64uI6rmMLA0K
7J207KCEIOydtOuplOydvOydhCDrsJvslZjripTsp4Ag7ZmV7J247ZWY6riwIOychO2VtCDsoITt
mZTtlojsirXri4jri6QuIOuLteyepeydhCDrs7TrgrTso7zshLjsmpQuDQrstZzrjIDtlZwg67mo
66asLg0K66Gk656c65OcDQo=

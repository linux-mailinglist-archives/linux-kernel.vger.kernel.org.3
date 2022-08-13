Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662665919A9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiHMJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiHMJio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:38:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2EB41D0D
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 02:38:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so10339526pjm.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc;
        bh=Dx1yhgJ9WrlrUuFJ23Ar5obCPV1TZcD98VuqH2DpeEk=;
        b=GFmTwgATH4+kGwjqyAl4IuVswZYj0Jr6hWmBWj1n5QVXL75LgYHWWo+bdVsBUFmH1S
         FmPhH4c+AkV39beodrN5/a5EnzQkCP5ee7p8fjChy/QNtQjYYRhgfk0ZuFPCOXMNy6CZ
         Tzn/PFWe3zV8DN0pYr/UuQX92yu57L2rTDzE/SNQrH8xCgSPceu9LSWz33T3JuU7gobZ
         V2nX81CiTDol8gLnGx/9xk0Vv/f1CRCz2PiqQ9z4UkPDKq/AucpoAOeXOl3Rcgn4E2I5
         H9+eMUYCS0KMSm3WlUeSwT/4BwhuQeJHGgg0Qfg4ATCQ/YxF8WlbsObR7iIVBBqSSycV
         LQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Dx1yhgJ9WrlrUuFJ23Ar5obCPV1TZcD98VuqH2DpeEk=;
        b=ax9Vl7037TLbcy5THyMj4pV2VqK2vt0W0/5zD/zAPPY0zHK84gJiMqX0rPWeoGf8zD
         jqLZkI4UsYC1DszP3zBNcHJhjJYV41y5ttoi12Z16QeVIfuBJDH5pJFlgMcMTzUmrMmB
         OB8KqZ0OqLt2qVcooz4xsvPr2UdpkjCHLWm/mgfrLdal3Kh/s/E7ne+UdDtAesR/s8O9
         NTHXujWVBYi6AyYryfMhUw3cGRRATUfC0y+k7D4IFh+wgu5P6+MUOuK7vhR2rHu383zT
         SvddNPthVJ4BkNzyDo7syEw4r/slDmXb4S5xUqK2QXSb0Oyc6Vg6V7UKz6biCelDv+FE
         Zv3A==
X-Gm-Message-State: ACgBeo24Ilui6VwpTr/ieKn7TfYVFOHBgvIsPaBo7eD+l+7YWT4cUujW
        /Xh3DfbFmQ1/FXiQpBuPrKvifUQ9VquZC6QRh2A=
X-Google-Smtp-Source: AA6agR7mnC/7LXHbxISqJxXoTVIdNdyQRZGjX5/78g7cqBAFAylSEiuz/EDi5x5MzM3YSrMYuCxl8jzlljaqNNkH1Z0=
X-Received: by 2002:a17:90b:4a87:b0:1f7:8c7b:931a with SMTP id
 lp7-20020a17090b4a8700b001f78c7b931amr8192005pjb.241.1660383523177; Sat, 13
 Aug 2022 02:38:43 -0700 (PDT)
MIME-Version: 1.0
Sender: dr.alitrouni@gmail.com
Received: by 2002:a17:902:f551:b0:16e:d000:5432 with HTTP; Sat, 13 Aug 2022
 02:38:42 -0700 (PDT)
From:   AISHA GADDAFI <madamisha00@gmail.com>
Date:   Sat, 13 Aug 2022 11:38:42 +0200
X-Google-Sender-Auth: 7MBNhFzdGfqTubHDwDSnNABKUss
Message-ID: <CAE+xecB4mdQkXXDdRgbCv+DG6Wto_e+wQZWpF0KSVY+shO4fhg@mail.gmail.com>
Subject: i wait for your responds
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_99,BAYES_999,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

44Ki44Kk44K344Oj44O744Ki44Or44O744Kr44OA44OV44Kj5Y2a5aOr44Gn44GZ44CC44OR44O8
44OI44OK44O844G+44Gf44Gv5oqV6LOH5a6244GM5b+F6KaB44Gq44Gu44Gn44CB44GC44Gq44Gf
44Gr6YCj57Wh44GX44G+44GZ44CCDQrnt4/poY0gMjc1MCDkuIfnsbPjg4njg6vjgpLoh6rliIbj
ga7lm73jgavmipXos4fjgZnjgovjga7jgpLoqrDjgYzmiYvkvJ3jgaPjgabjgY/jgozjgb7jgZnj
gYs/DQros4fph5Hjga/jg5bjg6vjgq3jg4rjg5XjgqHjgr3jgavlhaXph5HjgZXjgozjgabjgYTj
gb7jgZnjgYzjgIHnp4Hjga/lrZDkvpvjgZ/jgaHjgajkuIDnt5Ljgavjgqrjg57jg7zjg7Pjgavk
vY/jgpPjgafjgYTjgb7jgZnjgILoqbPntLDjgpLjgYrnn6XjgonjgZvjgZfjgb7jgZnjga7jgafj
gIHjgafjgY3jgovjgaDjgZHml6njgY/ov5Tkv6HjgZfjgabjgY/jgaDjgZXjgYTjgIINCuOCouOC
pOOCt+ODo+ODu+OCouODq+ODu+OCq+ODgOODleOCo+WNmuWjq+OAgg0K

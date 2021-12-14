Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804BC4745CD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhLNPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhLNPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:04 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4803C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:03:04 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id r15so35326569uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=y0AxHqVNz5e8rpcNxeLSY5v+3Ggy/2K7m2WeyjQfLEM=;
        b=oVMYTP0+qBLhU4UKmjRz9F0pHoi6cHl0KG/fsuwApZaApc6MPNzVXSEvqYwx4x8Qrw
         dlJJcxSDi/FfcowQhM6KR2lOs5AclK1mTHFK3YLtFiHij1vkCyQY0YX/1M7kuKb+DcCc
         ogdJzN0gWzQEZ4yQXElkvL7CS37SAzo/jzyPJxg3ZRMh5FYVuPJAQKy/Hjj183WzAlPS
         teoYUJb/Hb8WUF4iebCF7f4IPKCrU5qmPRb7Se8M/m9M6Wtr8vfpKOg/Pp7DSlchGcNA
         1ORyjlGTw/Z9dAeMajDRCYjDYJJrentR4QoyhrAmc5PvsxEz9fjf/F6cbPTgaEqXR8At
         5DwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=y0AxHqVNz5e8rpcNxeLSY5v+3Ggy/2K7m2WeyjQfLEM=;
        b=6vZ7s2N3QKeOyvcbdt/BN1/zO8UpjFlGE0fVt//Y8nHni5jXIvOCLWP1TQd2jUGUL2
         4a04gk4bYUnqaGOItx9hPUSNKGRnvSqXO3c/N+XM2L0aQPDWDhHPrdY7K0Ljmay1kj29
         lbBGOXAAU/Ub65j/aQ7RffEvEfPE/fnxu2cADZ1QuW/fFdIqMO+gJ2+xwyvEPjwUb3FU
         2hylaMMPuMsuVcPCP14TqJhOBjRxSSYidQOml4/vXGQZKbuHdD5v44jW90ti8M9RDsJI
         5f5sf8vlgkbXGdce4hB+I9kngjU/1k2McnjZ/CPAyvBNCt9wfdp0nYeqX4x93UDMTyRS
         DdHA==
X-Gm-Message-State: AOAM533xkwR4g9ZhIrKQHBMdRi8K4zNPE8IJR+ybrpg5FB7zuzkvbCpW
        0W441ChZImqJoPcnbF9roP++eNSuQUg5belDego=
X-Google-Smtp-Source: ABdhPJzzao+aBLjyrYJcEBp72u1U3aN3yj90M38u0txXK0QgscWIGadoqDwzjiXsfnx/19Q0tPNWkLI7CRMMwBSUsH0=
X-Received: by 2002:ab0:35d2:: with SMTP id x18mr5968851uat.32.1639494183549;
 Tue, 14 Dec 2021 07:03:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:612c:2108:b0:246:a783:e205 with HTTP; Tue, 14 Dec 2021
 07:03:03 -0800 (PST)
Reply-To: payenjane100@gmail.com
From:   payen jane <sawadogob52blokus@gmail.com>
Date:   Tue, 14 Dec 2021 07:03:03 -0800
Message-ID: <CAA-60z=nqZzTbFW-nWOBHe84hTFCrQnBX5DvU=RYOhB_B25pbg@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5Yqp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5oiR5biM5pyb5L2g6IO955CG6Kej6L+Z5p2h5L+h5oGv77yM5Zug5Li65oiR5q2j5Zyo5Yip55So
57+76K+R57uZ5L2g5YaZ5L+h44CCDQoNCuaIkeaYr+WIqeS6muWnhsK35L2p5oGp5Lit5aOr5aSr
5Lq644CCDQrlnKjnvo7lm73pmYblhpvnmoTlhpvkuovpg6jpl6jjgILnvo7lm73vvIzkuIDlkI3k
uK3lo6vvvIwzMiDlsoHvvIzmiJHljZXouqvvvIzmnaXoh6rnvo7lm73nlLDnurPopb/lt57lhYvl
iKnlpKvlhbDvvIznm67liY3pqbvmiY7lnKjlj5nliKnkuprvvIzkuI7mgZDmgJbkuLvkuYnkvZzm
iJjjgILmiJHnmoTljZXkvY3mmK/nrKw05oqk55CG6Zif56ysNzgy5peF5L+d6Zqc6JCl44CCDQoN
CuaIkeaYr+S4gOS4quWFhea7oeeIseW/g+OAgeivmuWunuWSjOa3seaDheeahOS6uu+8jOWFt+ac
ieiJr+WlveeahOW5vem7mOaEn++8jOaIkeWWnOasoue7k+ivhuaWsOaci+WPi+W5tuS6huino+S7
luS7rOeahOeUn+a0u+aWueW8j++8jOaIkeWWnOasoueci+WIsOWkp+a1t+eahOazoua1quWSjOWx
seiEieeahOe+juS4veS7peWPiuWkp+iHqueEtuaJgOaLpeacieeahOS4gOWIh+aPkOS+m+OAguW+
iOmrmOWFtOiDveabtOWkmuWcsOS6huino+aCqO+8jOaIkeiupOS4uuaIkeS7rOWPr+S7peW7uuer
i+iJr+WlveeahOWVhuS4muWPi+iwiuOAgg0KDQrmiJHkuIDnm7TlvojkuI3lvIDlv4PvvIzlm6Dk
uLrov5nkupvlubTmnaXnlJ/mtLvlr7nmiJHkuI3lhazlubPvvJvmiJHlpLHljrvkuobniLbmr43v
vIzpgqPlubTmiJEgMjENCuWygeOAguaIkeeItuS6suWPq+S5lOWwlMK35L2p5oGp77yM5q+N5Lqy
5Y+r546b5Li9wrfkvanmganjgILmsqHmnInkurrluK7liqnmiJHvvIzkvYblvojpq5jlhbTmiJHn
u4jkuo7lnKjnvo7lhpvkuK3mib7liLDkuoboh6rlt7HjgIINCg0K5oiR57uT5ama55Sf5LqG5a2p
5a2Q77yM5L2G5LuW5q275LqG77yM5LiN5LmF5oiR5LiI5aSr5byA5aeL5qy66aqX5oiR77yM5omA
5Lul5oiR5LiN5b6X5LiN5pS+5byD5ama5ae744CCDQoNCuaIkeS5n+W+iOW5uOi/kO+8jOWcqOaI
keeahOWbveWutuOAgee+juWbveWSjOWPmeWIqeS6mui/memHjO+8jOaLpeacieaIkeeUn+a0u+S4
remcgOimgeeahOS4gOWIh++8jOS9huayoeacieS6uue7meaIkeW7uuiuruOAguaIkemcgOimgeS4
gOS4quivmuWunueahOS6uuadpeS/oeS7u++8jOS7luS5n+S8muWwseWmguS9leaKlei1hOWQkeaI
keaPkOS+m+W7uuiuruOAguWboOS4uuaIkeaYr+aIkeeItuavjeWcqOS7luS7rOWOu+S4luWJjeeU
n+S4i+eahOWUr+S4gOWls+WtqeOAgg0KDQrmiJHkuI3orqTor4bkvaDmnKzkurrvvIzkvYbmiJHo
rqTkuLrmnInkuIDkuKrlgLzlvpfkv6HotZbnmoTlpb3kurrvvIzku5blj6/ku6Xlu7rnq4vnnJ/m
raPnmoTkv6Hku7vlkozoia/lpb3nmoTllYbkuJrlj4vosIrvvIzlpoLmnpzkvaDnnJ/nmoTmnInk
uIDkuKror5rlrp7nmoTlkI3lrZfvvIzmiJHkuZ/mnInkuIDkupvkuJzopb/opoHlkozkvaDliIbk
uqvnm7jkv6HjgILlnKjkvaDouqvkuIrvvIzlm6DkuLrmiJHpnIDopoHkvaDnmoTluK7liqnjgILm
iJHmi6XmnInmiJHlnKjlj5nliKnkuprov5nph4zotZrliLDnmoTmgLvpop3vvIg1NTANCuS4h+e+
juWFg++8ieOAguaIkeS8muWcqOS4i+S4gOWwgeeUteWtkOmCruS7tuS4reWRiuivieS9oOaIkeaY
r+WmguS9leWBmuWIsOeahO+8jOS4jeimgeaDiuaFjO+8jOS7luS7rOaYr+aXoOmjjumZqeeahO+8
jOaIkei/mOWcqOS4jiBSZWQNCuacieiBlOezu+eahOS6uumBk+S4u+S5ieWMu+eUn+eahOW4ruWK
qeS4i+Wwhui/meeslOmSseWtmOWFpeS6humTtuihjOOAguaIkeW4jOacm+aCqOWwhuiHquW3seS9
nOS4uuaIkeeahOWPl+ebiuS6uuadpeaOpeaUtuWfuumHkeW5tuWcqOaIkeWcqOi/memHjOWujOaI
kOWQjuehruS/neWug+eahOWuieWFqOW5tuiOt+W+l+aIkeeahOWGm+S6i+mAmuihjOivgeS7peWc
qOaCqOeahOWbveWutuS4juaCqOS8mumdou+8m+S4jeimgeWus+aAlemTtuihjOS8muWwhui1hOmH
keWtmOWCqOWcqA0KQVRNIFZJU0Eg5Y2h5Lit77yM6L+Z5a+55oiR5Lus5p2l6K+05piv5a6J5YWo
5LiU5b+r5o2355qE44CCDQoNCueslOiusDvmiJHkuI3nn6XpgZPmiJHku6zopoHlnKjov5nph4zl
kYblpJrkuYXvvIzmiJHnmoTlkb3ov5DvvIzlm6DkuLrmiJHlnKjov5nph4zkuKTmrKHngrjlvLno
oq3lh7vkuK3lubjlrZjkuIvmnaXvvIzov5nlr7zoh7TmiJHlr7vmib7kuIDkuKrlgLzlvpfkv6Ho
tZbnmoTkurrmnaXluK7liqnmiJHmjqXmlLblkozmipXotYTln7rph5HvvIzlm6DkuLrmiJHlsIbm
naXliLDkvaDku6znmoTlm73lrrblh7rouqvmipXotYTvvIzlvIDlp4vmlrDnlJ/mtLvvvIzkuI3l
ho3lvZPlhbXjgIINCg0K5aaC5p6c5oKo5oS/5oSP6LCo5oWO5aSE55CG77yM6K+35Zue5aSN5oiR
44CC5oiR5Lya5ZGK6K+J5L2g5LiL5LiA5q2l55qE5rWB56iL77yM5bm257uZ5L2g5Y+R6YCB5pu0
5aSa5YWz5LqO5Z+66YeR5a2Y5YWl6ZO26KGM55qE5L+h5oGv44CC5Lul5Y+K6ZO26KGM5bCG5aaC
5L2V5biu5Yqp5oiR5Lus6YCa6L+HIEFUTSBWSVNBDQpDQVJEIOWwhui1hOmHkei9rOenu+WIsOaC
qOeahOWbveWuti/lnLDljLrjgILoi6XmnInlhbTotqPor7fogZTns7vmnKzkurrjgIINCg==
